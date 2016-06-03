class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  include SessionHelper

  def check_current_user(message)
    if !current_user
      flash[:notice] = message
      redirect_to login_path
    end
  end

  protected

  def record_not_found
    render :file => 'public/404.html', :status => :not_found
  end
end
