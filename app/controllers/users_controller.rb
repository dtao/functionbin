class UsersController < ApplicationController
  def index
    @users = User.order(:score => :desc)
  end

  def show
    @user = User.find(params[:id])
    @implementations = @user.implementations.all(:include => :function)
  end
end
