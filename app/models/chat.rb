class Chat < ApplicationRecord
  validates :title, presence: true

  has_many :messages
  has_many :chat_users

  after_create_commit { broadcast_append_to "chats" }
end