class Address < ApplicationRecord
  belongs_to :user
  belongs_to :garage, optional: true
end
