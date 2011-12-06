class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :received_messageable, polymorphic: true
      t.references :sent_messageable, polymorphic: true
      t.string :subject
      t.text :body
      t.integer :flags, default: 0, null: false
      t.string :ancestry
      t.timestamps
    end
    add_index :messages, [:sent_messageable_id, :sent_messageable_type], name: :index_smi_smt
    add_index :messages, [:received_messageable_id, :received_messageable_type], name: :index_rmi_rmt
    add_index :messages, :flags
    add_index :messages, :ancestry
  end
end
