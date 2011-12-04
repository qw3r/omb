class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :omniauthable

  
  attr_accessor :login
  
  attr_accessible :login, :firstname, :lastname, :username, :email, :password, :password_confirmation, :remember_me
  
  has_many :sent_messages, class_name: 'Message', foreign_key: 'author_id'
  has_and_belongs_to_many :received_messages, class_name: 'Message', join_table: 'messages_recipients', foreign_key: 'recipient_id' 
  
  validates :username, uniqueness: {case_sensitive: false}
  
  # TODO: implemenet folders (Inbox, Sent, Draft, Trash...)
  
  def name
    "#{firstname} #{lastname}"
  end
  
  def to_recipient
    s = email
    s = "#{name} <#{s}>" unless name == ' '
    s
  end

  # class methods
  def self.find_for_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
  end
  
  def self.find_for_oauth_facebook(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.find_by_email(data.email)
      user
    else # Create a user with a stub password. 
      User.create!(email: data.email, password: Devise.friendly_token[0,20], username: data.email) 
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end
  
  
end


