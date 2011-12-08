class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :recipient
      t.references :sender
      t.string :subject
      t.text :body
      t.integer :flags, default: 0, null: false
      t.string :ancestry
      t.timestamps
    end
    add_index :messages, :recipient_id
    add_index :messages, :sender_id
    add_index :messages, :flags
    add_index :messages, :ancestry
  end
end
