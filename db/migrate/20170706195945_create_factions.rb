class CreateFactions < ActiveRecord::Migration[5.1]
  def change
    create_table :factions, id: :uuid do |t|
      t.string :name
      t.text :description
      t.integer :points
      t.boolean :public

      t.timestamps
    end
  end
end
