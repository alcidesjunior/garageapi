class Garage < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :comments
end
