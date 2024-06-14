class ChatsController < ApplicationController
  def create
    Chat.transaction do 
      title = params["chat"]["title"]
      chat = Chat.create(user_id: current_user.id, title: title)
      chat_user = ChatUser.create(user_id: current_user.id, chat_id: chat.id)
      @chat = chat
    end
  end

  def index
    @current_user = current_user
    redirect_to '/signin' if @current_user.nil?
    chats = Chat.all
    
    @users = User.all
    @chat = Chat.new
    
    messages = Hash[Message.where(chat_id: chats.map(&:id)).collect { |m| [m.chat_id, m] } ]
    last_messages = Hash[Message.where(chat_id: chats.map(&:id)).collect { |m| [m.chat_id, m.content] } ]

    @last_messages = last_messages

    recent_users = ChatUser.where.not(last_seen:nil).where('last_seen >= ?', 30.minutes.ago).group(:chat_id).count
    @recent_users = recent_users

    chats = chats.select{|x| x}.sort_by{ |x| recent_users[x.id].nil? ? 0 : recent_users[x.id]}.reverse
    @chats = chats
  end

  def show
    @current_user = current_user
    single_chat = Chat.find(params[:id])
    @single_chat = single_chat
    chats = Chat.all
    @chats = chats
    @users = User.all
    @chat = Chat.new
    
    @message = Message.new
    @messages = @single_chat.messages
  
    Chat.transaction do
      chat_user = ChatUser.where(user_id: current_user.id, chat_id: single_chat.id)
      if chat_user.count == 0
        ChatUser.create(chat_id: single_chat.id, user_id: current_user.id, last_seen: Time.now)

        msg = "#{current_user.name}님이 대화방에 들어왔습니다"
        
        Message.create(chat_id: single_chat.id, user_id: current_user.id, content: msg)
      else
        chat_user.update(last_seen: Time.now)
      end
    end

    recent_users = ChatUser.where.not(last_seen:nil).where('last_seen >= ?', 30.minutes.ago).group(:chat_id).count
    @recent_users = recent_users

    chats = chats.select{|x| x}.sort_by{ |x| recent_users[x.id].nil? ? 0 : recent_users[x.id]}.reverse
    @chats = chats

    render "index"
  end

  def join_chat
    user_id = params[:user_id]
    chat_id = params[:chat_id]
    user = User.find_by(id: user_id)
    chat = Chat.find_by(id: chat_id)

    chat_user_ids = chat.chat_users.map(&:user_id)
    # todo 정원초과 체크
    # raise Vb::Error.new(:member_exceed) if 
    msg = ""
    Chat.transaction do
      if !chat_user_ids.include?(user.id)
        ChatUser.create(chat_id: chat.id, user_id: user.id, last_seen: Time.now) unless chat_user_ids.include?(user.id)

        msg = "#{user.name}님이 대화방에 들어왔습니다"

        Message.create(chat_id: chat.id, user_id: user.id, content: msg)
      end
      chat
    end

    render json: {
      msg: msg
    }, status: :ok
  end
end