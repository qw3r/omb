class CreateMessagesRecipients < ActiveRecord::Migration
  
  create_table :messages_recipients, id: false do |t|
    t.belongs_to :message, null: false
    t.belongs_to :recipient, null: false
  end
  add_index :messages_recipients, :message_id
  add_index :messages_recipients, :recipient_id
  add_index :messages_recipients, [:message_id, :recipient_id], unique: true

end
