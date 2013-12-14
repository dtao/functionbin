source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use OmniAuth for user authentication
gem 'omniauth'
gem 'omniauth-github'

# Boy, do I hate whitespace!
gem 'strip_attributes'

# Let's version functions and implementations (for now)
gem 'paper_trail', '>= 3.0.0.rc2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use HAML (sometimes) for markup
gem 'haml-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Fast JSON serialization
gem 'oj'

# User profile images
gem 'gravatar_image_tag'

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Kill them N+1 queries
  gem 'bullet'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
