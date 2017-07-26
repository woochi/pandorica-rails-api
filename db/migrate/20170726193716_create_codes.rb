class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes, id: :uuid do |t|
      t.string :value

      t.timestamps
    end

    (1..200).each do |num|
      Code.create!
    end
  end
end
