FunctionBin::App.controllers :users do
  get :index do
    @users = FunctionBin::User.all(:order => [:name.asc])
    render(:'users/index')
  end

  get :index, :with => :id do |id|
    @user = FunctionBin::User.get(id)
    render(:'users/show')
  end
end
