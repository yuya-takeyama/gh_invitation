class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :github_authentication

  helper_method :logged_in?, :github_user, :github_user_id, :github_username

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
      set_access_token(github_access_token)
    end
  end

  def set_access_token(access_token)
    octokit.access_token = access_token
  end

  def logged_in?
    !!session['github_oauth']
  end

  def github_user
    @github_user ||= octokit.user
  end

  def github_user_id
    session['github_user_id']
  end

  def github_username
    session['github_username']
  end

  def github_access_token
    Hash[session].dig 'github_oauth', 'token'
  end
end
