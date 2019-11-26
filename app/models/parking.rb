class Parking < ApplicationRecord
  validates :garage_owner_id, presence: true
  validates :driver_id, presence: true
  validates :license_plate, presence: true
  validates :garage_id, presence: true
  validates :driver_id, presence: true
  validates :vehicle_id, presence: true
  # validates :start, presence: true

  belongs_to :garage
end
