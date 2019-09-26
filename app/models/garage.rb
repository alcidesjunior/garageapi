class Garage < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :comments
  has_one :parking
end
