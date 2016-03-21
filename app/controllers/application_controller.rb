class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :github_authentication

  private

  def octokit
    @octokit ||= Octokit::Client.new(
      client_id: Rails.configuration.github_client_id,
      client_secret: Rails.configuration.github_client_secret,
    )
  end

  def inviter
    @inviter ||= GhInvitation::Inviter.new(
      Octokit::Client.new(
        access_token: Rails.configuration.github_access_token,
      )
    )
  end

  def github_authentication
    unless request.path_info =~ %r{\A/(?:auth|login)}
      unless logged_in?
        redirect_to login_path
      end
    end

    if logged_in?
      octokit.access_token = session['github_oauth']['token']
    end
  end

  def logged_in?
    !!session['github_oauth']
  end
end
