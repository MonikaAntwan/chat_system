class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :chat_id
      t.integer :number
      t.string :body

      t.timestamps
    end

    add_index :messages, :chat_id, name: 'index_messages_on_chat_id'
  end
end
