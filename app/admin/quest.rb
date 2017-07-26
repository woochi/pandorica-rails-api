ActiveAdmin.register Quest do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :name, :description, :points, :published, :code

  index do
    selectable_column
    column :name
    column :description
    column :points
    column :published
    column :code
    actions do |quest|
      item "Preview", preview_admin_quest_path(quest), class: "member_link"
    end
  end

  action_item :view, only: :index do
    link_to 'Export Codes', export_admin_quests_path, target: "_blank"
  end

  member_action :preview do
    # This will render app/views/admin/posts/comments.html.erb
    @quest = resource
    @qr = RQRCode::QRCode.new(
      "https://app.ropecon.fi/quests/#{@quest.id}?code=#{@quest.code}",
      :size => 8,
      :level => :h
    )
  end

  collection_action :export do
    zipfile_name = "quests.zip"
    zipfile_path = "#{Rails.root}/tmp/#{zipfile_name}"
    image_names = []

    File.delete(zipfile_path)

    Quest.all.each do |quest|
      canvas = Magick::ImageList.new
      qr = RQRCode::QRCode.new(
        "https://app.ropecon.fi/quests?code=#{quest.code}",
        :size => 8,
        :level => :h
      ).as_png(size: 480).to_s
      qr_image = Magick::Image.from_blob(qr)[0]
      canvas << qr_image

      [
        quest.name,
        'Scan the QR code or fill\n the code below in the app:',
        quest.code.upcase,
        'Join the fight at app.ropecon.fi'
      ].each_with_index do |value, index|
        text_image = Magick::Image.new(480, index === 0 ? 30 : 100)
        text = Magick::Draw.new
        text.font_family = 'helvetica'
        text.pointsize = index === 2 ? 52 : 28
        text.gravity = Magick::CenterGravity
        text.annotate(text_image, 0,0,2,2, value) {
          self.fill = 'gray0'
        }
        canvas << text_image
      end

      image_name = "#{quest.name}.png"
      image_names << image_name
      canvas.append(true).write("#{Rails.root}/tmp/#{image_name}")
    end


    Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
      image_names.each do |image_name|
        # Two arguments:
        # - The name of the file as it will appear in the archive
        # - The original file, including the path to find it
        zipfile.add(image_name, "#{Rails.root}/tmp/#{image_name}")
      end
    end
    zip_data = File.read(zipfile_path)

    send_data(zip_data, :type => 'application/zip', :filename => zipfile_name)
  end
end
