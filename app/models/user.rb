class User < ApplicationRecord
  devise :database_authenticatable, :trackable, :recoverable

  has_many :user_locations
  has_many :locations, through: :user_locations
  has_many :posts

  def self.create_token_for(user)
    {
      user_id: user.id,
      email: user.email
    }
  end
end
