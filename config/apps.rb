Padrino.configure_apps do
  set :session_secret, ENV['SESSION_SECRET']
  set :protection, true
  set :protect_from_csrf, true
end

# Mounts the core application for this project
Padrino.mount('FunctionBin::App', :app_file => Padrino.root('app/app.rb')).to('/')
