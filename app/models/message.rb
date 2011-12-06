class Message < ActiveRecord::Base
  include FlagShihTzu
  
  has_ancestry
  has_flags 1 => :read,
            2 => :sender_deleted,
            3 => :recipient_deleted,
            4 => :sender_purged,
            5 => :recipient_purged
            

  belongs_to :received_messageable, polymorphic: true
  belongs_to :sent_messageable, polymorphic: true
  
  validates :subject, :body, presence: true
    
end

