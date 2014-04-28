class FriendCircle < ActiveRecord::Base
  belongs_to  :owner, foreign_key: :owner_id, class_name: 'User'
  has_many :friend_circle_memberships, dependent: :destroy
  has_many :members,
           through: :friend_circle_memberships,
           source: :member

  validates :name, presence: true
  validates :name, uniqueness: { scope: :owner_id }
  validates :owner_id, presence: true
end
