module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user
 
    # def connect
    #   self.current_user = find_verified_user
    # end
 
    # protected
    #   def find_verified_user
    #     if current_user = User.find_by(id: params[:user_id])
    #       current_user
    #     else
    #       reject_unauthorized_connection
    #     end
    #     @current_user
    #   end
  end
end

