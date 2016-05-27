class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper

  def check_current_user(message)
    if !current_user
      flash[:notice] = message
      render "sessions/new"
    end
  end

end
