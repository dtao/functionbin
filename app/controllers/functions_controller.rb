class FunctionsController < ApplicationController
  require_login_for :create, :comment

  def index
    @functions = Function.order(:name => :asc)
  end

  def show
    @function = Function.find(params[:id])

    @popular_implementations_json = Oj.dump(@function.implementations.map { |impl|
      {
        'name' => impl.user.name,
        'data' => [impl.upvotes.count]
      }
    })
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
