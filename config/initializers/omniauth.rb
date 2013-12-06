Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, ENV["GITHUB_CLIENT_ID_#{Rails.env.upcase}"], ENV["GITHUB_CLIENT_SECRET_#{Rails.env.upcase}"]
end
