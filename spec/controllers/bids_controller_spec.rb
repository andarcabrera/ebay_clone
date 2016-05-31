require 'rails_helper'

describe BidsController do
  let(:seller) { User.create(username: "muggle", email: "haveamug@example.com", password: "muggle4lyfe") }
  let(:bidder) { User.create(username: "mugger", email: "needamug@example.com", password: "muglyfe") }
  let(:item) { Item.create(name: "mug", description: "black", current_bid: 200, seller_id: seller.id) }

  context "bid is succesful" do
    before (:each) do
      login_user(bidder)
    end

    it "response is successful" do
      post :create, :item_id => item.id, :bid => { amount: 300 }

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to bid confirmation page" do
      post :create, :item_id => item.id, :bid => { amount: 300 }

      expect(response).to redirect_to(action: "show", item_id: item.id, id: Bid.last.id )
    end

    it "creates a new bid" do
      count = Bid.count
      post :create, :item_id => item.id, :bid => { amount: 300 }

      expect(Bid.count).to eq(count + 1)
    end

    it "updates the item's current_bid" do
      post :create, :item_id => item.id, :bid => { amount: 300 }

      expect(Item.find(item.id).current_bid).to eq(300)
      expect(Item.find(item.id).available).to be false
    end
  end

  context "bid is unsuccessfull" do
    context "the amount is smaller than the current bid on the item" do
      before (:each) do
        login_user(bidder)
      end

      it "should have an unprocessable entity status" do
        post :create, :item_id => item.id, :bid => { amount: 100 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end

      it "should render the items index page" do
        post :create, :item_id => item.id, :bid => { amount: 100 }

        expect(response).to render_template("items/index")
      end
    end

    context "user is not logged in" do
      it "renders login page" do
        post :create, :item_id => item.id, :bid => { amount: 100 }

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq("text/html")
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq("You need to be logged in to bid on this item")
      end
    end

    context "item is not available" do
      before (:each) do
        login_user(bidder)
      end

      it "should have an unprocessable entity status" do
        item.update_attributes(available: false)
        post :create, :item_id => item.id, :bid => { amount: 400 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end

      it "should render the items index page" do
        item.update_attributes(available: false)
        post :create, :item_id => item.id, :bid => { amount: 400 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end
    end

    context "amount is not given" do
      before (:each) do
        login_user(bidder)
      end

      it "should have an unprocessable entity status" do
        item.update_attributes(available: false)
        post :create, :item_id => item.id, :bid => {}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end

      it "should render the items index page" do
        item.update_attributes(available: false)
        post :create, :item_id => item.id, :bid => {}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end
    end
  end

  def login_user(user)
    session[:user_id] = user.id
  end
end
