class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user.slice(:id, :username, :image_url, :bio), status: :ok
        else
          render json: { error: "Invalid username or password" }, status: :unauthorized
        end
      end
    
      def destroy
        session[:user_id] = nil
        head :no_content
      end
  
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    
end
