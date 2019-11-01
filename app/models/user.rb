class User < ApplicationRecord
  has_secure_password

  validates_length_of :password, minimum: 8, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  # validates :document_number, presence: false, uniqueness: true

  has_many :addresses
  has_many :garages
  has_one :vehicle
  has_one :parking


  def can_mofidy_user?(user_id)
    role == 'admin' || id.to_s == user_id.to_s
  end

  def is_admin
    role == 'admin'
  end

  # def self.from_token_payload payload
  #   puts "==============="
  #   puts payload["sub"]
  #   puts "==============="
  # end
end
