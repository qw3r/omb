class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  
  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :firstname, :lastname, :username, :email, :password, :password_confirmation, :remember_me
  
  
  
  def name
    "#{firstname} #{lastname}"
  end


  def self.find_for_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
  
end


