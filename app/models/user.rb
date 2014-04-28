class User < ActiveRecord::Base
  has_many :friend_circle_memberships, dependent: :destroy
  has_many :friend_circles, through: :friend_circle_memberships, inverse_of: :users

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

  private

  def ensure_session_token
    self.session_token = generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def generate_password_digest( password )
    BCrypt::Pasword.create( password )
  end
end
