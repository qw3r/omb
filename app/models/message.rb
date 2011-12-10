class Message < ActiveRecord::Base
  include FlagShihTzu
  
  has_ancestry
  has_flags 1 => :read,
            2 => :deleted_by_sender,
            3 => :deleted_by_recipient,
            4 => :purged_by_sender,
            5 => :purged_by_recipient,
            flag_query_mode: :bit_operator 
            

  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'
  
  
  scope :deleted, -> { deleted_by_sender.deleted_by_recipient }
  scope :for_user, lambda {|*args| where(["(sender_id = :uid AND #{Message.flags_condition(args.last, :deleted_by_sender)} AND #{Message.not_purged_by_sender_condition}) OR (recipient_id = :uid AND #{Message.flags_condition(args.last, :deleted_by_recipient)} AND #{Message.not_purged_by_recipient_condition})", uid: args.first.id ]) }
                                                                              
  validates :subject, :body, presence: true
 
  def self.flags_condition(cond, flag)
    flag = flag.to_s << '_condition' 
    Message.send(cond ? flag : 'not_' + flag)
  end
  
  def unread?
    !read?
  end
  
  def mark_as_read
    update_attribute :read, true
  end
  
  def mark_as_unread
    update_attribute :read, :false
  end
  
  def from
    sender
  end
    
  def to
    recipient
  end
  
  def thread
    root.subtree
  end
end

