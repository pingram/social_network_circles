class Link < ActiveRecord::Base
  validates :title, :url, presence: true

  belongs_to :post, inverse_of: :links
end
