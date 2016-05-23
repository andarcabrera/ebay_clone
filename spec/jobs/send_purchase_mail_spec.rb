require 'sidekiq/testing'

describe SendPurchaseMail do
  let(:item) { Item.create(name: "shirt", description: "cotton", price: 1, email: "me@example.com") }
  let(:purchase) { Purchase.create(email: "you@example.com", item_id: item.id) }
  let(:mailer) { double 'ItemSoldMailer' }

  xit 'job sends mailer correct args' do
    worker = SendPurchaseMail.new
    worker.perform(purchase.id, item.id)

    expect(ActionMailer::Base.deliveries[0].to[0]).to eq(item.email)
    expect(ActionMailer::Base.deliveries[0].body.raw_source).to include(purchase.email)
  end
end
