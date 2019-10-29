class Vehicle < ApplicationRecord
  belongs_to :user
  has_one :parking

  validates :chassi, presence: true, uniqueness: true
  validates :license_plate, presence: true, uniqueness: true
  validates :user_id, presence: true
end
