require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module OhMyJetlag
  class Application < Rails::Application
    config.load_defaults 8.0

    config.autoload_lib(ignore: %w[assets tasks])

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [ :ru, :en ]
    config.i18n.default_locale = :ru

    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc
    # config.active_job.queue_adapter = :sidekiq
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
