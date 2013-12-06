class AuthController < ApplicationController
  def authenticate
    @user = find_or_create_user(auth_hash['info'])
    session[:user_id] = @user
    redirect_to(root_path)
  end

  def find_or_create_user(user_info)
    user = User.find_by(:email => user_info['email'])

    if user.nil?
      user = User.create!({
        :name => user_info['nickname'],
        :email => user_info['email']
      })

      alert("Welcome to the site, #{user.name}!")

    else
      alert("Welcome back, #{user.name}!")
    end

    user
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
