require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsForAzureWebapps
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    config.time_zone = "Tokyo"
    config.i18n.default_locale = :ja
    # config.eager_load_paths << Rails.root.join("extras")

    # semantic_loggerの設定
    # 開発環境などはJSON形式にすると見にくいのでRails標準に近づける
    config.rails_semantic_logger.semantic = false
    config.rails_semantic_logger.started = true
    config.rails_semantic_logger.processing = true
    config.rails_semantic_logger.rendered = true

    # 入力フォームのバリデーションエラーのときに挿入されるタグをカスタマイズする
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| content_tag :span, html_tag, class: "my_field_with_errors" }
  end
end
