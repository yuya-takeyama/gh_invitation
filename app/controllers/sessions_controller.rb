class SessionsController < ApplicationController
  def login
  end

  def callback
    session['github_oauth'] = request.env['omniauth.auth']['credentials']

    set_access_token(github_access_token)

    session['github_user_id'] = github_user.id
    session['github_username'] = github_user.login

    redirect_to root_path
  end

  def logout
    session.delete 'github_oauth'

    redirect_to login_path
  end
end
