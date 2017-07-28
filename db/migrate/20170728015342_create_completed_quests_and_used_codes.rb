class CreateCompletedQuestsAndUsedCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_completions, id: :uuid do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :quest, type: :uuid, null: false, index: true

      t.timestamps
    end

    create_table :code_uses, id: :uuid do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :code, type: :uuid, null: false, index: true

      t.timestamps
    end
  end
end
