class HomeController < ApplicationController
  def index
  end

  def login
    if request.post?
      user = User.find_by(:email => params[:email])

      if user.nil?
        flash[:notice] = "Let's get you registered."
        return redirect_to(register_path(:email => params[:email]))
      end

      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}."
      return redirect_to(root_path)
    end
  end

  def register
    @email = params[:email]

    if request.post?
      user = User.create!(:name => params[:name], :email => params[:email])
      session[:user_id] = user.id
      flash[:notice] = "Thanks for registering, #{user.name}."
      redirect_to(root_path)
    end
  end

  def logout
    session.delete(:user_id)
    return redirect_to(root_path)
  end
end
