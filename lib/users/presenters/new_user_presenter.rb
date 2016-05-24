class NewUserPresenter

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def errors
    @user.errors.full_messages
  end
end
