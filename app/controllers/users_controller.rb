    # app/controllers/users_controller.rb
class UsersController < ApplicationController

    wrap_parameters format:[]
    def create
        user = User.create(user_params)
        if user.valid?
          session[:user_id] = user.id
          render json: user
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def show
        if logged_in?
          render json: current_user
        else
          render json: { error: "Not authorized" }, status: :unauthorized
        end
      end
  
    private
  
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
end

