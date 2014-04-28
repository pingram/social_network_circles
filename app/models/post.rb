class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_shares
  has_many :friend_circles, through: :post_shares
  has_many :links, inverse_of: :post
end
