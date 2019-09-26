class Vehicle < ApplicationRecord
  belongs_to :user
  has_one :parking
end
