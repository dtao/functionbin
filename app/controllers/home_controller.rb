class HomeController < ApplicationController
  def index
  end

  def login
    if request.post?
      user = User.find_by(:email => params[:email])

      if user.nil?
        alert("Let's get you registered.", :warning)
        return redirect_to(register_path(:email => params[:email]))
      end

      session[:user_id] = user.id
      alert("Welcome back, #{user.name}.", :success)
      return redirect_to(root_path)
    end
  end

  def register
    @email = params[:email]

    if request.post?
      user = User.create!(:name => params[:name], :email => params[:email])
      session[:user_id] = user.id
      alert("Thanks for registering, #{user.name}.", :success)
      redirect_to(root_path)
    end
  end

  def logout
    session.delete(:user_id)
    return redirect_to(root_path)
  end
end
