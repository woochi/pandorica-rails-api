class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  belongs_to :faction
  has_many :quest_completions
  has_many :quests, through: :quest_completions

  has_many :code_uses
  has_many :codes, through: :code_uses
end
