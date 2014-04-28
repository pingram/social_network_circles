class FriendCircleMembership < ActiveRecord::Base
  belongs_to :member,
             foreign_key: :member_id,
             primary_key: :id,
             class_name: 'User'

  belongs_to :friend_circle
end
