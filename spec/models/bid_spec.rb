require 'rails_helper'

describe Bid do
  let(:seller) { User.create(username: "muggle", email: "haveamug@example.com", password: "muggle4lyfe") }
  let(:bidder) { User.create(username: "mugger", email: "needamug@example.com", password: "muglyfe") }
  let(:item) { Item.create(name: "mug", description: "black", starting_bid_price: 200, seller_id: seller.id) }
  let(:bid) { Bid.create(item_id: item.id, bidder_id: bidder.id, amount: 300) }

  context "bid is valid" do
    it "has an item_id" do
      expect(bid.item_id).to eq(item.id)
    end

    it "has a bidder_id" do

      expect(bid.bidder_id).to eq(bidder.id)
    end

    it "has an amount" do

      expect(bid.amount).to eq(300)
    end
  end

  context "bid is not valid" do
    it "does not create bid if amount is smaller than current bid" do
      invalid_bid =  Bid.create(item_id: item.id, bidder_id: bidder.id, amount: 100)

      expect(invalid_bid.errors).to include(:amount)
    end

    it "does not create bid if amount is smaller  than current bid" do
      item.available = false
      item.save
      invalid_bid =  Bid.create(item_id: item.id, bidder_id: bidder.id, amount: 500)

      expect(invalid_bid.errors).to include(:unavailable_item)
    end
  end
end

