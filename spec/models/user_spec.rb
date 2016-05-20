describe User do
  context "valid user" do
    let(:user) { User.new(username: "Jeff", email: "rogerthat@example.com", password: "intriguing") }
    it "has a username" do

      expect(user.username).to eq("Jeff")
    end

    it "has an email" do

      expect(user.email).to eq("rogerthat@example.com")
    end

    it "has a password" do

      expect(user.password).to eq("intriguing")
    end
  end

  context "invalid user" do
    it "doesn't save without a username" do
      user = User.create(email: "sassyapprentice@example.com", password: "domeavfavorrealquick")

      expect(user.errors).to include(:username)
    end

    it "doesn't save without an email" do
      user = User.create(username: "craftsman", password: "domeavfavorrealquick")

      expect(user.errors).to include(:email)
    end

    it "doesn't save without an password" do
      user = User.create(username: "Chris", email: "niceshoes@example.com")

      expect(user.errors).to include(:password)
    end
  end

  context "email is not unique" do
    it "does not create a user with invalid email" do
      user1 = User.create(username: "chi-hugger", email: "chris@example.com", password: "itsfun")
      user2 = User.create(username: "chi-hugger-roommate", email: "chris@example.com", password: "itsreallyfun")

      expect(user2.errors).to include(:email)
    end
  end

  context "a user has many items" do
    it "retrieves the items a user has" do
      user = User.create(username: "mrEnthusiatic", email: "awesomesauce@example.com", password: "what?!!!!")
      item1 = Item.create(name: "velociraptor", description: "watch out", price: 600, user_id: user.id)
      item2 = Item.create(name: "centaur", description: "mythical", price: 540, user_id: user.id)

      expect(user.items).to eq([item1, item2])
    end
  end
end

