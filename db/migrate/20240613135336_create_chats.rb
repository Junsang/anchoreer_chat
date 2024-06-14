class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      # t.integer :id
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
