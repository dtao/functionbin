class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordInvalid, :with => :show_validation_errors

  helper_method [:logged_in?, :current_user]

  def self.require_login_for(*actions)
    self.before_filter :require_login, :only => actions
  end

  def alert(message, style=:info)
    flash[:notice] = message
    flash[:style]  = style
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(:id => session[:user_id])
  end

  def require_login
    unless logged_in?
      alert('You must be logged in to do that.', :warning)
      redirect_to(request.referrer)
    end
  end

  def show_validation_errors(error)
    alert(error.record.errors.first[1], :error)
    redirect_to(request.referrer)
  end
end
