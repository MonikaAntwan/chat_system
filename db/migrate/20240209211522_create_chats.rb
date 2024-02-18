class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :application_id
      t.string :name
      t.integer :number
      t.integer :messages_count, default: 0

      t.timestamps
    end

    add_index :chats, :application_id, name: 'index_chats_on_application_id'
  end
end
