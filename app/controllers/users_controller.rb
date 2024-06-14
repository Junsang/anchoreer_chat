class UsersController < ApplicationController
  def index
    user = User.find_by(id:1)

    
    ret = user.as_json
    render json: ret
  end
end