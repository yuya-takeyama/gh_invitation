require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GhInvitation
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.before_initialize do
      %w(
        GITHUB_CLIENT_ID
        GITHUB_CLIENT_SECRET
        GITHUB_ACCESS_TOKEN
      ).each do |key|
        raise "Environmental variable #{key} is not defined" unless ENV.key? key
      end

      Rails.application.config.github_client_id     = ENV['GITHUB_CLIENT_ID']
      Rails.application.config.github_client_secret = ENV['GITHUB_CLIENT_SECRET']
      Rails.application.config.github_access_token  = ENV['GITHUB_ACCESS_TOKEN']
    end
  end
end
