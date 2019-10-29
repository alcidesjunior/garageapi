class Garage < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :comments
  has_one :parking

  validates :parking_spaces, presence: true
  validates :price, presence: true
end
