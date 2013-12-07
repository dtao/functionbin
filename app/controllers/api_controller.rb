class ApiController < ApplicationController
  def index
    function_names = params[:functions].split('+')

    # Find all functions with the specified names
    function_ids = Function.where(:name => function_names).map(&:id)

    # Find all implementations for the specified functions
    # (This should be quick; I wouldn't expect there to be tons of implementations
    # for any given function.)
    implementations = Implementation.where(:function_id => function_ids).all(:include => :function)

    # Pick the top-rated implementation for each function
    @implementations = implementations.group_by(&:function_id).map do |function_id, impls|
      impls.sort_by(&:score).last
    end

    render(:action => "#{params[:format] || 'browser'}.js", :'content-type' => 'text/javascript')
  end
end
