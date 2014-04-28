class FriendCircleMembership < ActiveRecord::Base
  belongs_to :user, :friend_circle
end
