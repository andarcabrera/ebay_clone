class SessionsController < ApplicationController
  def create
    if user = User.authenticate(session_params)
      session[:user_id] = user.id
      redirect_to items_path
    else
      flash[:notice] = "Incorrect email/password combination. You are on a secure website my friend."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to items_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
