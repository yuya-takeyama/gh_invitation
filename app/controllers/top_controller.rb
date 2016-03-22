class TopController < ApplicationController
  def index
  end

  def invite
    begin
      res = inviter.invite params[:username]
      binding.pry
      res
    rescue => e
      binding.pry
    end
  end
end
