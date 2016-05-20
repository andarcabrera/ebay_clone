require 'rails_helper'

describe ItemsController do

  context "request for home page" do

    it "response is successful" do
      get :index

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the index template" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  context "request for new item" do
    it "response is successful" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  context "new item is created successfully" do
    it "response is successful" do
      post :create, :item => {name: "a", description: "A", price: 1, user_id: 1}

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to the root" do
      post :create, :item => {name: "a", description: "some description", price: 1, user_id: 1}

      expect(response).to redirect_to(:root)
    end

    it "adds the item to the database" do
      post :create, :item => {name: "ping-pong paddle", description: "you beat Alex with it", price: 1, user_id: "a"}

      expect(Item.first.name).to eq("ping-pong paddle")
      expect(Item.count).to eq(1)
    end
  end

  context "new item is invalid and not created" do
    it "response is successful" do
      post :create, :item => {name: "", description: "some description", price: 1, user_id: 1}

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the new template" do
      post :create, :item => {name: "", description: "A", price: 1, user_id: 1}

      expect(response).to render_template(:new)
    end

    it "does not save the item to the database" do
      post :create, :item => {name: "", description: "A", price: 1, user_id: 1}

      expect(Item.count).to eq(0)
    end
  end
end

