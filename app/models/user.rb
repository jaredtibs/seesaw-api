class User < ApplicationRecord
  devise :database_authenticatable, :trackable, :recoverable

  has_many :user_locations
  has_many :locations, through: :user_locations
  has_many :posts

end
