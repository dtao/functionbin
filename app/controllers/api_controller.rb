class ApiController < ApplicationController
  # Expose functions Node-style
  def node
    function_ids = params[:ids].split(',')

    # Find all implementations for the specified functions
    # (This should be quick; I wouldn't expect there to be tons of implementations
    # for any given function.)
    @implementations = Implementation.where(:function_id => function_ids).all(:include => :function)

    # Pick the top-rated implementation for each function
    @implementations = @implementations.group_by(&:function_id).map do |function_id, impls|
      impls.sort_by(&:score).last
    end

    respond_to do |format|
      format.js { render(:action => 'node') }
    end
  end
end
