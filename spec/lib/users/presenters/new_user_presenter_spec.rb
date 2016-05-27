require 'rails_helper'
require 'users/presenters/new_user_presenter'

describe NewUserPresenter do

  let(:user) { double 'user' }
  let(:presenter) { NewUserPresenter.new(user) }

  it "returns a new user" do

    expect(presenter.user).to eq(user)
  end

   it "returns the error" do
    allow(user).to receive_message_chain(:errors, :full_messages) { "That's a no-no!" }

    expect(presenter.errors).to eq("That's a no-no!")
  end
end
