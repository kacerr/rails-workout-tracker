class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create :init
  validates :first_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    uniqueness: { case_sensitive: false }  
  #,
  #                  format:     { with: VALID_EMAIL_REGEX },
  #                  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_one :profile
  has_many :workouts
  has_many :received_messages, class_name: "Message", foreign_key: "to_user_id"
  has_many :sent_messages, class_name: "Message", foreign_key: "from_user_id"
  has_many :groups, foreign_key: "owner_id"
  has_many :memberships, :dependent => :destroy
  has_many :groupparticipations, :through => :memberships
  has_many :workout_joins

  VISIBILITY_TYPES = {
    0 => "only me",
    1 => "my groups",
    2 => "everybody"
  }

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

    def init
      self.user_class ||= 'user'
    end

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end  

end
