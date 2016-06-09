describe SessionHelper do
  it "returns a user if the session id is valid" do
    user = User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz")
    session[:user_id] = user.id

    expect(current_user.id).to eq(user.id)
  end

  it "returns nil if the session is invalid" do
    session[:user_id] = nil

    expect(current_user).to be_nil
  end
end
