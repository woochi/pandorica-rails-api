class AddPointsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :points, :integer, null: false, default: 0
  end
end
