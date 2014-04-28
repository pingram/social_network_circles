class User < ActiveRecord::Base
  has_many :friend_circle_memberships,
           foreign_key: :member_id,
           dependent: :destroy

  has_many :associated_circles,
           through: :friend_circle_memberships,
           source: :member

  has_many :owned_circles, foreign_key: :owner_id, class_name: 'FriendCircle'
  has_many :posts

  attr_reader :password

  before_validation :ensure_session_token

  validates :email, :session_token, presence: true
  validates :password_digest, presence: { message: "password can't be blank" }
  validates :password, length: { minimum: 6, allow_blank: true }
  validates :password, presence: true, on: :create

  def password=( password )
    @password = password
    self.password_digest = generate_password_digest( password )
  end

  def is_password?( password )
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end


  private

  def ensure_session_token
    self.session_token = generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def generate_password_digest( password )
    BCrypt::Password.create( password )
  end
end
