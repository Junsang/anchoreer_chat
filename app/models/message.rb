
class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  after_create_commit { broadcast_append_to self.chat }

  def to_data
    data = attributes.slice('id', 'user_id', 'chat_id', 'content', 'created_at')
    data
  end
end