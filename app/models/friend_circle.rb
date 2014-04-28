class FriendCircle < ActiveRecord::Base
  has_many :friend_circle_memberships, dependent: :destroy
  has_many :users, through: :friend_circle_memberships, inverse_of: :friend_circles
end
