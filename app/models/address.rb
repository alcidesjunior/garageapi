class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :garage, optional: true

  validates :zip, presence: true
  validates :street, presence: true
  validates :number, presence: true
  validates :city, presence: true
  validates :uf, presence: true
end
