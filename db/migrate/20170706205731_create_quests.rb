class CreateQuests < ActiveRecord::Migration[5.1]
  def change
    create_table :quests, id: :uuid do |t|
      t.string :name
      t.text :description
      t.integer :points
      t.boolean :published

      t.timestamps
    end
  end
end
