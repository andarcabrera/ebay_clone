require 'sidekiq/testing'

describe AuctionWorker do

  context "bid goes through successfully" do
    let (:seller) { User.create(username: "bagel", email: "bring@itback.com", password: "plaincreamcheese") }
    let (:bidder1) { User.create(username: "oatmeal", email: "brownsugar@melt.com", password: "noquinoa") }
    let (:bidder2) { User.create(username: "coffee", email: "black@melt.com", password: "noquinoa") }
    let!(:bid1) { Bid.create(bidder_id: bidder1.id, item_id: item.id, amount: 300) }
    let!(:bid2) { Bid.create(bidder_id: bidder2.id, item_id: item.id, amount: 400) }
    let(:mailer) { double 'ItemSoldMailer' }

    let(:item) { Item.create(name: "shirt", description: "cotton", starting_bid_price: 1, seller_id: seller.id, auction_end_time: "2019-06-01 12:00:00 -0600") }
    before(:each) do
      ActionMailer::Base.deliveries = []
      worker = AuctionWorker.new
      worker.perform(item.id)
    end
    it 'finds the correct winning_bid' do

      expect(item.bids.find_by(amount: item.highest_bid)).to eq(bid2)
    end

    it 'creates a purchase' do

      expect(Purchase.count).to eq(1)
    end

    it 'marks the item as unavailable' do

      expect(item.reload.available).to be false
    end

    it 'sends emails to seller' do

      expect(ActionMailer::Base.deliveries[0].to[0]).to eq(item.seller.email)
      expect(ActionMailer::Base.deliveries[0].body.raw_source).to include(bidder2.email)
    end

    it 'sends emails to winning bidder/purchaser' do

      expect(ActionMailer::Base.deliveries[1].to[0]).to eq(bidder2.email)
      expect(ActionMailer::Base.deliveries[1].body.raw_source).to include(seller.email)
    end

  end

  context "bid ends but purchase does not happen" do

    context "item is not available" do
      let (:seller) { User.create(username: "bagel", email: "bring@itback.com", password: "plaincreamcheese") }
      let (:bidder) { User.create(username: "oatmeal", email: "brownsugar@melt.com", password: "noquinoa") }
      let(:item) { Item.create(name: "shirt", description: "cotton", available: false, starting_bid_price: 1, seller_id: seller.id, auction_end_time: "2019-06-01 12:00:00 -0600") }
      let!(:bid) { Bid.create(bidder_id: bidder.id, item_id: item.id, amount: 300) }
      let(:mailer) { double 'ItemSoldMailer' }
      before(:each) do
        ActionMailer::Base.deliveries = []
        worker = AuctionWorker.new
        worker.perform(item.id)
      end

      it 'job sends mailer correct args' do

        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end

    context "there are no bids on the item" do
      let (:seller) { User.create(username: "bagel", email: "bring@itback.com", password: "plaincreamcheese") }
      let (:bidder) { User.create(username: "oatmeal", email: "brownsugar@melt.com", password: "noquinoa") }
      let(:item) { Item.create(name: "shirt", description: "cotton", starting_bid_price: 1, seller_id: seller.id, auction_end_time: "2019-06-01 12:00:00 -0600") }
      let(:mailer) { double 'ItemSoldMailer' }
      before(:each) do
        ActionMailer::Base.deliveries = []
        worker = AuctionWorker.new
        worker.perform(item.id)
      end

      it 'job sends mailer correct args' do

        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
  end
end
