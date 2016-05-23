class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      redirect_to :root
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
