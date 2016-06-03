require 'rails_helper'

describe BidsController do
  let(:seller) { User.create(username: "muggle", email: "haveamug@example.com", password: "muggle4lyfe") }
  let(:bidder) { User.create(username: "mugger", email: "needamug@example.com", password: "muglyfe") }
  let(:item) { Item.create(name: "mug", description: "black", starting_bid_price: 200, seller_id: seller.id, auction_end_time: "2019-06-01 12:00:00 -0600") }

  context "bid is successful" do
    before (:each) do
      login_user(bidder)
    end

    it "response is successful" do
      post :create, :item_id => item.id, :amount => 300

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to bid confirmation page" do
      post :create, :item_id => item.id, :amount => 300

      expect(response).to redirect_to(action: "show", item_id: item.id, id: Bid.last.id )
    end

    it "creates a new bid" do
      count = Bid.count
      post :create, :item_id => item.id, :amount => 300

      expect(Bid.count).to eq(count + 1)
    end
  end

  context "bid is unsuccessfull" do
    context "the amount is smaller than the current bid on the item" do
      before (:each) do
        login_user(bidder)
      end

      it "should have an unprocessable entity status" do
        post :create, :item_id => item.id, :amount => 100

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end

      it "should render the items show page" do
        post :create, :item_id => item.id, :amount => 100

        expect(response).to render_template("items/show")
      end
    end

    context "user is not logged in" do
      it "renders login page" do
        post :create, :item_id => item.id, :amount => 100

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
        post :create, :item_id => item.id, :amount => 400

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end

      it "should render the items show page" do
        item.update_attributes(available: false)
        post :create, :item_id => item.id, :amount => 400

        expect(response).to render_template(:show)
      end
    end

    context "amount is not given" do
      before (:each) do
        login_user(bidder)
      end

      it "should have an unprocessable entity status" do
        post :create, :item_id => item.id

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("text/html")
      end

      it "should render the items show page" do
        post :create, :item_id => item.id

        expect(response).to render_template(:show)
      end
    end
  end

  def login_user(user)
    session[:user_id] = user.id
  end
end
