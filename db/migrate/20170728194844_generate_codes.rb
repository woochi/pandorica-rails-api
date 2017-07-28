class GenerateCodes < ActiveRecord::Migration[5.1]
  def change
    (1..100).each do |num|
      Code.create!(value: Code.generate_unique_code, points: 200)
    end
  end
end
