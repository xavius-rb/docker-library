def source_paths
  [__dir__]
end

def add_gems
  say '--- Adding new gems...'

  gem_group :xavius do
    gem 'redis'
    gem 'draper'
    gem 'sidekiq'
    gem 'devise'
    gem 'pundit'
  end

  gem_group :development, :test do
    gem 'rspec-rails'
  end
end

def setup_devise
  generate "devise:install"
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
  generate :devise, "User", "role:string"
end

def setup_pundit
  generate "pundit:install"
end

def setup_draper
  generate "draper:install"
end

def create_home_index
  generate :controller, "home", "index"
  route "root to: 'home#index'"
end

def setup_sidekiq
  environment "config.active_job.queue_adapter = :sidekiq"

  insert_into_file "config/routes.rb",
    "require 'sidekiq/web'\n\n",
    before: "Rails.application.routes.draw do"

  content = <<-RUBY
  mount Sidekiq::Web => '/sidekiq'
  RUBY

  insert_into_file "config/routes.rb", "#{content}\n\n", after: "Rails.application.routes.draw do\n"

  initializer 'sidekiq.rb', <<-RUBY
  require 'sidekiq'
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['WORKER_URL'] }
  end
  RUBY
end

def setup_redis_cache
  run "bundle exec rails dev:cache"
  environment "config.cache_store = :redis_cache_store, { url: ENV['CACHE_URL'] }"
end

def dockerize
  say "--- Dockerizing..."
  copy_file "Dockerfile"
  copy_file "docker-compose.yml"
  copy_file ".app.env"
end

def config!
  FileUtils.mkdir_p("tmp/pids")
  copy_file "database.yml", "config/database.yml"
end

source_paths
config!
add_gems
dockerize

after_bundle do
  setup_draper
  create_home_index
  setup_redis_cache
  setup_sidekiq if yes?("--- Setup Sidekiq?")
  setup_devise if yes?("--- Setup Devise?")
  setup_pundit if yes?("--- Setup Pundit?")
  say "Xavius booting template complete!", :green
end
