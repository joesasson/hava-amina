class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  def authenticate_user!
    unless current_user.id == params[:user_id].to_i
      flash[:alert] = "You are not logged as this user"
      redirect_to :root
    end
  end
end
