class ImplementationsController < ApplicationController
  def new
    @function = Function.find(params[:id])
  end

  def show
    @implementation = Implementation.find(params[:id])
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

  private

  def implementation_params
    params.require(:implementation).permit(:function_id, :source)
  end
end
