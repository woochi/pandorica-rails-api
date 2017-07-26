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

  member_action :preview do
    # This will render app/views/admin/posts/comments.html.erb
    @quest = resource
    @qr = RQRCode::QRCode.new(
      "https://app.ropecon.fi/quests/#{@quest.id}?code=#{@quest.code}",
      :size => 8,
      :level => :h
    )
  end
end
