class AddFactionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :faction_id, :uuid, null: false, default: Faction.first.id
    add_index :users, :faction_id
  end
end
