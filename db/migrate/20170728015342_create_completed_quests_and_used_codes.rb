class CreateCompletedQuestsAndUsedCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_completions, id: :uuid do |t|
      t.belongs_to :user, index: true
      t.belongs_to :quest, index: true

      t.timestamps
    end

    create_table :code_uses, id: :uuid do |t|
      t.belongs_to :user, index: true
      t.belongs_to :code, index: true

      t.timestamps
    end
  end
end
