require 'sidekiq/testing'

describe SendPurchaseMail do
  let (:seller) { User.create(username: "bagel", email: "bring@itback.com", password: "plaincreamcheese") }
  let (:purchaser) { User.create(username: "oatmeal", email: "brownsugar@melt.com", password: "noquinoa") }
  let(:item) { Item.create(name: "shirt", description: "cotton", buy_it_now_price: 1, seller_id: seller.id, starting_bid_price: 2, auction_end_time: Time.now + 2.days) }
  let(:purchase) { Purchase.create(purchaser_id: purchaser.id, item_id: item.id) }
  let(:mailer) { double 'ItemSoldMailer' }

  it 'job sends mailer correct args' do
    worker = SendPurchaseMail.new
    worker.perform(purchase.id, item.id)

    expect(ActionMailer::Base.deliveries[0].to[0]).to eq(item.seller.email)
    expect(ActionMailer::Base.deliveries[0].body.raw_source).to include(purchase.purchaser.email)
  end
end
