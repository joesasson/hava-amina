class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    # from_omniauth(request.env['omniauth.auth'])
    # session[:user_id] = @identity.user.id
    # # @user = User.find()
    # render :plain => 'Hello ' + @identity.provider
  end
  # def linkedin
  #   find_or_create_identity(request.env['omniauth.auth'])
  # end
  # def google
  #   find_or_create_identity(request.env['omniauth.auth'])
  # end
  # def github
  #   find_or_create_identity(request.env['omniauth.auth'])
  # end
end
