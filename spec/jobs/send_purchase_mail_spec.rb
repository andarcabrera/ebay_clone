require 'sidekiq/testing'

describe SendPurchaseMail do
  let(:item) { Item.create(name: "shirt", description: "cotton", price: 1, email: "me@example.com") }
  let(:purchase) { Purchase.create(email: "you@example.com", item_id: item.id) }

  it 'enqueues a job with the correct args' do
    Sidekiq::Testing.fake!

    SendPurchaseMail.perform_async(purchase.id, item.id)
    expect(SendPurchaseMail.jobs[0]["args"]).to eq([purchase.id, item.id])
  end
end
