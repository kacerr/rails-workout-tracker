class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :first_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true
  #,
  #                  format:     { with: VALID_EMAIL_REGEX },
  #                  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :workouts
  has_many :received_messages, class_name: "Message", foreign_key: "to_user_id"
  has_many :sent_messages, class_name: "Message", foreign_key: "from_user_id"
  after_initialize :init

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def isAdmin?
    self.user_class=="admin"
  end


  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end  

    def init
      self.user_class ||= 'user'
    end
end
