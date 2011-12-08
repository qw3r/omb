class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :omniauthable

  
  has_many :received_messages_relation, foreign_key: 'recipient_id', class_name: 'Message'
  has_many :sent_messages_relation, foreign_key: 'sender_id', class_name: 'Message'
   
  attr_accessor :login
  
  attr_accessible :login, :firstname, :lastname, :username, :email, :password, :password_confirmation, :remember_me
  
  validates :username, uniqueness: {case_sensitive: false}
  
  def messages(deleted = false)
    Message.for_user self, deleted
  end
  
  def deleted_messages
    messages true
  end
  
  def received_messages(deleted = false)
    received_messages_relation.send "#{'not_' unless deleted}deleted_by_recipient"
  end
  
  def sent_messages(deleted = false)
    sent_messages_relation.send "#{'not_' unless deleted}deleted_by_sender"
  end
  
  def send_message(to, args = {})
    message = Message.create! args
    sent_messages_relation << message
    to.received_messages_relation << message
    message
  end
  
  def reply_to(message, args = {})
    reply = send_message(message.from, args)
    # reply.subject = 'RE: ' << message.subject
    reply.parent = message
    reply.save
    reply
  end

  def delete_message(message)
    if message.recipient == self
      if message.deleted_by_recipient?
        message.update_attribute :purged_by_recipient, true
      else
        message.update_attribute :deleted_by_recipient, true
      end
    elsif message.sender == self
      if message.deleted_by_sender?
        message.update_attribute :purged_by_sender, true
      else
        message.update_attribute :deleted_by_sender, true
      end
    end
  end
  
  
  def name
    "#{firstname} #{lastname}" unless firstname.blank? and lastname.blank?
  end
  
  def to_recipient
    s = email
    s = "#{name} <#{s}>" if name.present?
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


