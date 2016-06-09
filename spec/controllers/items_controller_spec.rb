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
    let(:user) { User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz") }
    before(:each) do
      login_user(user)
    end

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
    let(:user) { User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz") }
    let(:item_params) { {name: "ping-pong paddle",
                         description: "you beat Alex with it",
                         buy_it_now_price: 1,
                         user_id: user.id} }

    before(:each) do
      login_user(user)
    end

    it "response redirect" do
      post :create, :item => item_params

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to items index" do
      post :create, :item => item_params

      expect(response).to redirect_to items_path
    end

    it "adds the item to the database" do
      post :create, :item => item_params

      expect(Item.first.name).to eq("ping-pong paddle")
      expect(Item.count).to eq(1)
    end

    it "creates an item with multiple tags" do
      post :create, :item => item_params, :tags => "joy, fun"

      expect(Item.first.tags.count).to eq(2)
      expect(Item.first.tags[0].name).to eq("joy")
      expect(Item.first.tags[1].name).to eq("fun")
    end

    it "it creates an item without any tags" do
      post :create, :item => item_params

      expect(Item.first.tags.count).to eq(0)
    end
  end

  context "new item is invalid and not created" do
    context "name is blank" do
      let(:user) { User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz") }
      before(:each) do
        login_user(user)
      end

      it "response is unprocessable_entity" do
        post :create, :item => {name: "", description: "some description", buy_it_now_price: 1, user_id: user.id}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end

      it "renders the new template" do
        post :create, :item => {name: "", description: "A", buy_it_now_price: 1, user_id: user.id}

        expect(response).to render_template(:new)
      end

      it "does not save the item to the database" do
        post :create, :item => {name: "", description: "A", buy_it_now_price: 1, user_id: user.id}

        expect(Item.count).to eq(0)
      end
    end

    context "no starting bid or buy it now price are present" do
      let(:user) { User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz") }
      before(:each) do
        login_user(user)
      end

      it "response is unprocessable_entity" do
        post :create, :item => {name: "can", description: "some description", user_id: user.id}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end

      it "renders the new template" do
        post :create, :item => {name: "cando", description: "A", user_id: user.id}

        expect(response).to render_template(:new)
      end

      it "does not save the item to the database" do
        post :create, :item => {name: "candowhat", description: "A", user_id: user.id}

        expect(Item.count).to eq(0)
      end
    end

    context "no current_user" do
      let(:user) { User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz") }
      it "redirects to log_in path" do
        post :create, :item => {name: "", description: "A", buy_it_now_price: 1, user_id: user.id}

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(login_path)
      end

      it "flashes a notice" do
        post :create, :item => {name: "", description: "A", buy_it_now_price: 1, user_id: user.id}

        expect(flash[:notice]).to eq("You need to be logged in to add an item")
      end
    end
  end

  context "item show page is requested" do
    context "existing item is requested" do
      let(:user) { User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz") }
      let(:item) { Item.create(name: "a", description: "A", buy_it_now_price: 17, seller_id: user.id) }
      before(:each) do
        login_user(user)
      end

      it "response is successful" do
        get :show, :id => item.id

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("text/html")
      end

      it "renders the show template" do
        get :show, :id => item.id

        expect(response).to render_template(:show)
      end
    end

    context "non-existing item is requested" do
      it "renders 404 page" do
        get :show, id: 5

        expect(response).to have_http_status(:not_found)
        expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
      end
    end
  end

  private

  def login_user(user)
    session[:user_id] = user.id
  end
end
