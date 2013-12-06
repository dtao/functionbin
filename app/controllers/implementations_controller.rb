class ImplementationsController < ApplicationController
  require_login_for :new, :create, :upvote, :comment

  def new
    @function = Function.find(params[:id])
  end

  def show
    @implementation = Implementation.find(params[:id])
    @comments = @implementation.comments.order(:id => :asc).all(:include => :user)
  end

  def create
    implementation = current_user.implementations.create!(implementation_params)
    redirect_to(implementation.function)
  end

  def upvote
    implementation = Implementation.find(params[:id])
    current_user.upvote!(implementation)
    redirect_to(implementation.function)
  end

  def comment
    implementation = Implementation.find(params[:id])
    current_user.comments.create!(:parent => implementation, :content => params[:content])
    redirect_to(implementation)
  end

  private

  def implementation_params
    params.require(:implementation).permit(:function_id, :source)
  end
end
