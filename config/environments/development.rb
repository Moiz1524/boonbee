Rails.application.configure do
  Bullet.enable = true # for N+1 queries
  # Bullet.alert = true
  Bullet.bullet_logger = true
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.quiet = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  config.action_mailer.default_url_options = { host: 'https://freelance-a17100262.c9users.io' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :port      => 587,
    :address => 'smtp.mailgun.org',
    :domain  => ENV['domain'],
    :user_name => ENV['username'],
    :password => ENV['password'],
    :authentication => :plain
    }
end
