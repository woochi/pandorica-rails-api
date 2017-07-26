class AddCodesToQuests < ActiveRecord::Migration[5.1]
  def change
    add_column :quests, :code, :string
    add_index :quests, :code, unique: true

    Quest.find_each do |quest|
      quest.code = Quest.generate_code
      quest.save!
    end
  end
end
