class Comment < ApplicationRecord
  has_one :user
  belongs_to :garage

  validates_presence_of :from_user_id#, message: "from_user_id can't be empty"
  validates_presence_of :to_user_id#, message: "to_user_id can't be empty"
  validates_presence_of :garage_id
end
