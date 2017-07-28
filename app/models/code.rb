class Code < ApplicationRecord
  validates_uniqueness_of :value

  def self.generate_code
    ('a'..'z').to_a.shuffle[0,5].join
  end

  def self.generate_unique_code
    begin
      code = Code.generate_code
    end while Code.find_by(value: code)

    code
  end
end
