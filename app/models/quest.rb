class Quest < ApplicationRecord
  validates_uniqueness_of :code
  before_create :set_code

  def self.generate_unique_code
    begin
      code = Code.generate_code
    end while Quest.find_by(code: code)

    code
  end

  private

  def set_code
    self.code = Quest.generate_unique_code
  end
end
