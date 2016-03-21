class SessionsController < ApplicationController
  def login
  end

  def callback
    session['github_oauth'] = request.env['omniauth.auth']['credentials']

    redirect_to root_path
  end

  def logout
    session.delete 'github_oauth'

    redirect_to login_path
  end
end
