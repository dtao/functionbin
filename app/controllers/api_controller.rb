class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    function_names = params[:functions].split('+')

    implementations = implementations_from_function_names(function_names)

    # Pick the top-rated implementation for each function
    @implementations = implementations.group_by(&:function_id).map do |function_id, impls|
      impls.sort_by(&:score).last
    end

    render(:action => "#{params[:format] || 'browser'}.js", :'content-type' => 'text/javascript')
  end

  def binfile
    data = parse_binfile_data(params[:functions])

    @implementations = implementations_from_function_names(data.keys).group_by(&:function_id)
    @implementations = @implementations.map do |function_id, impls|
      function = impls.first.function
      function_data = data[function.name]

      implementation = if function_data[:user_name]
        impls.find { |impl| impl.user.name == data[function.name][:user_name] }
      else
        impls.sort_by(&:score).last
      end

      if function_data[:version]
        implementation = implementation.versions[function_data[:version] - 1].reify
      end

      implementation
    end

    render(:action => "#{params[:format] || 'browser'}.js", :'content-type' => 'text/javascript')
  end

  private

  # So here's the format I'm looking for (at the moment):
  #
  # {
  #   "functions": [
  #     "function1",
  #     "function2/user1",
  #     ["function3/user2", 2]
  #   ]
  # }
  def parse_binfile_data(binfile_data)
    dependencies = binfile_data.map do |data|
      dependency, version = data.is_a?(Array) ? data : data.split(/\s+/)
      function_name, user_name = dependency.split('/')

      {
        :function_name => function_name,
        :user_name => user_name,
        :version => version
      }
    end

    dependencies.inject({}) do |hash, data|
      hash[data[:function_name]] = data
      hash
    end
  end

  def implementations_from_function_names(function_names)
    # Find all functions with the specified names
    function_ids = Function.where(:name => function_names).map(&:id)

    # Find all implementations for the specified functions
    # (This should be quick; I wouldn't expect there to be tons of implementations
    # for any given function.)
    Implementation.where(:function_id => function_ids).includes(:function)
  end
end
