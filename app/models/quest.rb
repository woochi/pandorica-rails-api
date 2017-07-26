class Quest < ApplicationRecord
  validates_uniqueness_of :code
  before_create :set_code

  def self.generate_code
    begin
      code = ('a'..'z').to_a.shuffle[0,5].join
    end while Quest.find_by(code: code)

    code
  end

  private

  def set_code
    self.code = Quest.generate_code
  end
end
