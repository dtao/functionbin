module FunctionBin
  class App < Padrino::Application
    register SassInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    helpers do
      def current_user
        @current_user ||= User.get(session[:user_id])
      end

      def logged_in?
        !!current_user
      end
    end

    get :index do
      render(:index)
    end

    get :login do
      render(:login)
    end

    get :logout do
      session.delete(:user_id)
      redirect('/')
    end

    post :login do
      user = User.first(:email => params['email'])

      if user.nil?
        halt(redirect("/register?email=#{params['email']}"))
      end

      session[:user_id] = user.id
      redirect('/')
    end

    get :register do
      @email = params['email']
      render(:register)
    end

    post :register do
      user = User.create(:name => params['name'], :email => params['email'])
      session[:user_id] = user.id
      redirect('/')
    end
  end
end
