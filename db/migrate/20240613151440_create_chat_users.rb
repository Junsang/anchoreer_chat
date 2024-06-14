class CreateChatUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_users do |t|
      # t.integer :id
      t.references :user, foreign_key: true, index: true
      t.references :chat, foreign_key: true, index: true

      t.datetime :last_seen

      t.timestamps
    end
  end
end
