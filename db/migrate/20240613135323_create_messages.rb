class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      # t.integer :id
      t.references :user, foreign_key: true, index: true
      t.references :chat, foreign_key: true, index: true
      t.string :content

      t.timestamps
    end
  end
end
