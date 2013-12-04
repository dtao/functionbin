FunctionBin::App.controllers :implementations do
  get :new, :map => '/functions/:id/implement' do |id|
    @function = FunctionBin::Function.get(id)
    render(:'implementations/new')
  end

  get :index, :with => :id do |id|
    @implementation = FunctionBin::Implementation.get(id)
    render(:'implementations/show')
  end

  post :index do
    implementation = current_user.implementations.create({
      :function_id => params['function_id'],
      :source => params['source']
    })

    redirect("/implementations/#{implementation.id}")
  end
end
