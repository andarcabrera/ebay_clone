require 'sidekiq/testing'

describe AuctionWorker do
  let (:seller) { User.create(username: "bagel", email: "bring@itback.com", password: "plaincreamcheese") }
  let (:bidder) { User.create(username: "oatmeal", email: "brownsugar@melt.com", password: "noquinoa") }
  let(:item) { Item.create(name: "shirt", description: "cotton", starting_bid_price: 1, seller_id: seller.id) }
  let(:bid) { Bid.create(bidder_id: bidder.id, item_id: item.id, amount: 300) }
  let(:mailer) { double 'ItemSoldMailer' }

  it 'job sends mailer correct args' do
    bid
    worker = AuctionWorker.new
    worker.perform(item.id)

    expect(ActionMailer::Base.deliveries.count).to eq(2)
    expect(ActionMailer::Base.deliveries[0].to[0]).to eq(item.seller.email)
    expect(ActionMailer::Base.deliveries[0].body.raw_source).to include(bidder.email)
    expect(ActionMailer::Base.deliveries[1].to[0]).to eq(bidder.email)
    expect(ActionMailer::Base.deliveries[1].body.raw_source).to include(seller.email)
  end
end
