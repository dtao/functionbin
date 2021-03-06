class FunctionsController < ApplicationController
  require_login_for :new, :create, :comment

  def index
    @functions = Function.order(:id => :desc).all(:include => :user)
  end

  def show
    @function = Function.find(params[:id])
    @comments = @function.comments.order(:id => :asc).all(:include => :user)
    @implementations = @function.implementations.order(:score => :desc).all(:include => :user)
    @popular_implementations = @implementations.select(&:has_upvotes?).map do |impl|
      {
        'name' => impl.user.name,
        'data' => [impl.upvotes.count]
      }
    end

    @popular_implementations_json = Oj.dump(@popular_implementations)
  end

  def create
    function = current_user.functions.create!(function_params)
    redirect_to(function)
  end

  def comment
    function = Function.find(params[:id])
    current_user.comments.create!(:parent => function, :content => params[:content])
    redirect_to(function)
  end

  private

  def function_params
    params.require(:function).permit(:name, :description, :example)
  end
end
