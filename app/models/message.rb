class Message < ActiveRecord::Base
  has_ancestry orphan_strategy: :restrict, cache_depth: true

  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :recipients, class_name: 'User', join_table: 'messages_recipients', association_foreign_key: 'recipient_id'
  
  attr_accessor :to
  attr_accessible :to


end
