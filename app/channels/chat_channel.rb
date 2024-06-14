class ChatChannel < ApplicationCable::Channel
    
    def subscribed
      stream_from "chats-#{current_user.id}"
    end
   
    def unsubscribed
      stop_all_streams
    end
   
    def speak(data)
      message_params = data['message'].each_with_object({}) do |el, hash|
        hash[el.values.first] = el.values.last
      end
   
      Message.create(message_params)

      ActionCable.server.broadcast(
        "chats-#{current_user.id}",
        message: message_params
      )
    end
  
    def receive(data)
      message(data)
    end
  
    def message(data)
      chat = Chat.find_by(id: data['chat_id'])
      return unless chat
      return if data['content'].nil?
  
      Message.create(
          chat_id: data['chat_id'],
          user_id: current_user.id,
          content: data['content'],
      )
  
      UserChannel.broadcast_to(current_user, data)
    end
  end
end