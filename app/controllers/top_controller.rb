class TopController < ApplicationController
  def index
    @user = octokit.user
  end
end
