class Comment < ApplicationRecord
  has_one :user
  belongs_to :garage

  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  validates :garage_id, presence: true
end
