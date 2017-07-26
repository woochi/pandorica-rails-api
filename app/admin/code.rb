ActiveAdmin.register Code do
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

  index do
    selectable_column
    column :value
    actions do |quest|
      item "Preview", preview_admin_code_path(quest), class: "member_link"
    end
  end

  #action_item :view, only: :index do
  #  link_to 'Export codes', export_admin_codes_path, target: "_blank"
  #end


  #collection_action :export do
  #  image = MiniMagick::Image.new('tmp.jpg')
  #  puts image.path
  #  send_data(image.to_blob, :disposition => 'inline', :type => 'image/jpg')
  #end

  member_action :preview do
    # This will render app/views/admin/posts/comments.html.erb
    @code = resource
    @qr = RQRCode::QRCode.new(
      "https://app.ropecon.fi/codes?value=#{@code.value}",
      :size => 8,
      :level => :h
    )
  end
end
