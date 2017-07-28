class AddPointsToCodes < ActiveRecord::Migration[5.1]
  def change
    add_column :codes, :points, :integer, null: false, default: 150
  end
end
