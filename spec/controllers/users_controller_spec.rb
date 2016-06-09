require 'rails_helper'

describe UsersController do
  context "request to sign up" do
    it "response is successful" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders new users template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  context "new user is successfully created" do
    it "response is succesful" do
      post :create, :user => {username: "pamplemousse", email: "lacroix@example.com", password: "chosenone" }

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to the item index page" do
      post :create, :user => {username: "pamplemousse", email: "lacroix@example.com", password: "chosenone" }

      expect(response).to redirect_to items_path
    end

    it "adds a user to the database"  do
      post :create, :user => {username: "pamplemousse", email: "lacroix@example.com", password: "chosenone" }

      expect(User.last.username).to eq("pamplemousse")
      expect(User.count).to eq(1)
    end

    it "it logs in the user"  do
      post :create, :user => {username: "pamplemousse", email: "lacroix@example.com", password: "chosenone" }

      expect(session[:user_id]).to eq(User.last.id)
    end
  end

  context "new user is not created" do
    it "response is unprocessable_entity" do
      post :create, :user => {email: "lacroix@example.com", password: "chosenone" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq("text/html")
    end

    it "render the new template" do
      post :create, :user => {email: "lacroix@example.com", password: "chosenone" }

      expect(response).to render_template(:new)
    end

    it "does not save the user to the database" do
      post :create, :user => {email: "lacroix@example.com", password: "chosenone" }

      expect(User.count).to eq(0)
    end
  end
end
