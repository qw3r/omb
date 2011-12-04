class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :author
      t.string :subject
      t.text :body
      t.boolean :read, default: false
      t.boolean :deleted, dafault: false
      t.string :ancestry
      t.integer :ancestry_depth, default: 0
      t.timestamps
    end
    add_index :messages, :author_id
    add_index :messages, :ancestry
    add_index :messages, :ancestry_depth
  end
end
