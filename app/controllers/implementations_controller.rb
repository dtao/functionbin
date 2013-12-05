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

  get :upvote, :map => '/implementations/:id/upvote' do |id|
    implementation = FunctionBin::Implementation.get(id)

    if current_user.upvoted?(implementation)
      flash[:notice] = "You already upvoted this implementation."
      halt redirect("/functions/#{implementation.function_id}")
    end

    if current_user == implementation.user
      flash[:notice] = "You cannot upvote your own implementation."
      half redirect("/functions/#{implementation.function_id}")
    end

    current_user.upvotes.create(:implementation => implementation)
    redirect("/functions/#{implementation.function_id}")
  end
end
