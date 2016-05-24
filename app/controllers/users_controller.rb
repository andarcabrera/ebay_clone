require 'users/presenters/new_user_presenter'

class UsersController < ApplicationController
  def new
    @presenter = NewUserPresenter.new(User.new)
  end

  def create
    user = User.new(user_params)
    @presenter = NewUserPresenter.new(user)
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
