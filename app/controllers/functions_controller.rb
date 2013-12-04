FunctionBin::App.controllers :functions do
  get :index do
    @functions = FunctionBin::Function.all(:order => [:name.asc])
    render(:'functions/index')
  end

  get :index, :with => :id do |id|
    @function = FunctionBin::Function.get(id)

    @popular_implementations_json = Oj.dump(@function.implementations.map { |impl|
      {
        'name' => impl.user.name,
        'data' => [impl.upvotes.count]
      }
    })

    render(:'functions/show')
  end

  post :index do
    function = current_user.functions.create({
      :name => params['name'],
      :description => params['description'],
      :example => params['example']
    })

    redirect("/functions/#{function.id}")
  end
end
