class User < ApplicationRecord
  has_secure_password

  validates_length_of :password, minimum: 8, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  validates_presence_of :email
  validates_uniqueness_of :email

  belongs_to :comment
  has_many :addresses
  has_many :garages
  has_one :vehicle


  def can_mofidy_user?(user_id)
    role == 'admin' || id.to_s == user_id.to_s
  end

  def is_admin
    role == 'admin'
  end
end
