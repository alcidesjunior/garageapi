class Comment < ApplicationRecord
  has_one :user
  belongs_to :garage
end
