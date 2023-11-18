class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :room_types, foreign_key: 'creator_id'
  has_many :reservations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: [:user, :admin]

  before_create :default_role

  def default_role
    self.role ||= :user
  end
end
