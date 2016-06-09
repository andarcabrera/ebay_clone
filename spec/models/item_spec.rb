require 'rails_helper'

describe Item do
  context "item is valid" do
    let(:seller) { User.create(username: "Mr. Cheetos", email: "cheesy@cheese.com", password: "itainteastbeingcheesy") }
    let(:item) { Item.create(name: "socks", starting_bid_price: 30, description: "they come in pairs", buy_it_now_price: 10, seller_id: seller.id, auction_end_time: "2019-06-01 12:00:00 -0600") }

    it "has a name" do

      expect(item.name).to eq("socks")
    end

    it "has a description" do

      expect(item.description).to eq("they come in pairs")
    end

    it "has a buy_it_now_price" do

      expect(item.buy_it_now_price).to eq(10)
    end

    it "has an seller_id" do

      expect(item.seller_id).to eq(seller.id)
    end

    it "has availablity" do

      expect(item.available).to eq(true)
    end

    it "has a starting_bid_price" do

      expect(item.starting_bid_price).to eq(30)
    end

    it "has an auction end time" do

      expect(item.auction_end_time).to eq(DateTime.new(2019, 6, 1, 12, 0, 0, '-6'))
    end
  end

  context "item is invalid" do
    let(:seller) { User.create(username: "Mr. Cheetos", email: "cheesy@cheese.com", password: "itainteastbeingcheesy") }

    it "doesn't save without a name" do
      item = create_invalid_item(description: "Hi", buy_it_now_price: 12, seller_id: seller.id)

      expect(item.errors).to include(:name)
    end

    it "doesn't save without a description" do
      item = create_invalid_item(name: "Jerome", buy_it_now_price: 12, seller_id: seller.id)

      expect(item.errors).to include(:description)
    end

    it "doesn't save without a seller_id" do
      item = create_invalid_item(name: "Jerome", description: "hot water", buy_it_now_price: 14)

      expect(item.errors).to include(:seller_id)
    end

    it "doesn't save without either a starting_bid_price or a buy_it_now_price" do
      item = create_invalid_item(name: "Jerome", description: "hot water", seller_id: seller.id)

      expect(item.errors).to include(:price)
    end

    it "doesn't save without complete auction details" do
      item = create_invalid_item(name: "Jerome", description: "hot water", starting_bid_price: 45, seller_id: seller.id)

      expect(item.errors).to include(:auction_details)
    end

    it "doesn't save if time until auction_end_time is less than 2 hours" do
      item = create_invalid_item(name: "Jerome", description: "hot water", starting_bid_price: 45, auction_end_time: "2016-06-01 12:00:00 -0600", seller_id: seller.id)

      expect(item.errors).to include(:auction_duration)
    end
  end

  private

  def create_invalid_item(item_details)
    item = Item.create(item_details)
  end
end
