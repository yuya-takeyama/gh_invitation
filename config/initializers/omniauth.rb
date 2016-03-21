Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.configuration.github_client_id, Rails.configuration.github_client_secret, scope: "read:org"
end
