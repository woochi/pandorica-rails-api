class CodeUse < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
end
