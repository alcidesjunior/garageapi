class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :garage, optional: true
end
