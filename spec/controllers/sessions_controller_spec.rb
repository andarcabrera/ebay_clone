describe SessionsController do

  context "request for login page" do
    it "has a successful response" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the new session template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  context "login successful" do
    let(:user) { User.new(username: "chosen", email: "thechosenone@example.com", password: "guitarman") }
    before(:each) do
      user.save
    end

    it "has a successful response" do
      post :create, session: { email: "thechosenone@example.com", password: "guitarman" }

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to the item index page" do
      post :create, session: { email: "thechosenone@example.com", password: "guitarman" }

      expect(response).to redirect_to items_path
    end

    it "creates a session for the user" do
      post :create, session: { email: "thechosenone@example.com", password: "guitarman" }

      expect(session[:user_id]).to eq(user.id)
    end

    it "does not show a flash message" do
      post :create, session: { email: "thechosenone@example.com", password: "guitarman" }

      expect(flash[:notice]).to be_nil
    end
  end

  context "login is unsuccessful due to incorrect credentials" do
    let(:user) { User.new(username: "chosen", email: "thechosenone@example.com", password: "guitarman")}
    before(:each) do
      user.save
    end

    it "has a sunprocessable_entitiy response" do
      post :create, session: { email: "thechosenone@example.com", password: "ukaleileman" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the login page" do
      post :create, session: { email: "thechosenone@example.com", password: "tambourineman" }

      expect(response).to render_template(:new)
    end

    it "shows a flash message" do
      post :create, session: { email: "thechosenone@example.com", password: "tambourineman" }

      expect(flash[:notice]).to eq("Incorrect email/password combination. You are on a secure website my friend.")
    end

    it "does not create a session for the user" do
      post :create, session: { email: "thechosenone@example.com", password: "tambourineman" }

      expect(session[:user_id]).to be_nil
    end
  end

  context "login is unsuccessful due to incomplete credentials" do
    context "no email provided" do
      it "renders login page" do
        post :create, session: { password: "ukaleileman" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
        expect(response).to render_template(:new)
      end

      it "shows a flash message" do
        post :create, session: { password: "ukaleileman" }

        expect(flash[:notice]).to eq("Incorrect email/password combination. You are on a secure website my friend.")
      end

      it "does not create a session for the user" do
        post :create, session: { password: "ukaleileman" }

        expect(session[:user_id]).to be_nil
      end
    end

    context "no password provided" do
      it "renders login page" do
        post :create, session: { email: "thechosenone@example.com" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
        expect(response).to render_template(:new)
      end

      it "shows a flash message" do
        post :create, session: { email: "thechosenone@example.com" }

        expect(flash[:notice]).to eq("Incorrect email/password combination. You are on a secure website my friend.")
      end

      it "does not create a session" do
        post :create, session: { email: "thechosenone@example.com" }

        expect(session[:user_id]).to be_nil
      end
    end

    context "user successfully logs out" do
        let(:user) { User.new(username: "chosen", email: "thechosenone@example.com", password: "guitarman") }
      before(:each) do
        user.save
      end

      it "redirects to the items index" do
        post :create, session: { email: "thechosenone@example.com", password: "guitarman" }
        delete :destroy

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq("text/html")
        expect(response).to redirect_to items_path
      end

      it "deletes the session" do
        post :create, session: { email: "thechosenone@example.com", password: "guitarman" }
        delete :destroy

        expect(session[:user_id]).to be_nil
      end
    end
  end
end
