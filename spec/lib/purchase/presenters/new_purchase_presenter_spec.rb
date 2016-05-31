require 'rails_helper'
require 'purchase/presenters/new_purchase_presenter'

describe NewPurchasePresenter do

  let (:seller) { double "seller", id: 3, email: "hey@you.com" }
  let (:purchaser) { double "purchaser", id: 3, email: "areyouthere@email.com" }
  let (:purchase) { double "purchase", id: 3, purchaser: purchaser, purchaser_id: purchaser.id, item_id: item.id }
  let (:item) { double "item", id: 3, seller: seller, name: "phone", description: "smart", buy_it_now_price: 3, seller_id: seller.id }
  let (:presenter) { NewPurchasePresenter.new(purchase, item) }

  it "returns the purchase it's given" do

    expect(presenter.purchase).to eq(purchase)
  end

  it "returns the item it's given" do

    expect(presenter.item).to eq(item)
  end

  it "return the item_id" do

    expect(presenter.item_id).to eq(item.id)
  end

  it "returns the purchaser's email" do

    expect(presenter.purchaser_email).to eq("areyouthere@email.com")
  end

  it "returns the item name" do

    expect(presenter.item_name).to eq("phone")
  end

  it "returns item buy_it_now_price" do

    expect(presenter.item_buy_it_now_price).to eq(3)
  end

  it "return the seller's email" do

    expect(presenter.seller_email).to eq("hey@you.com")
  end

  it "returns an error for invalid purchase" do
    allow(purchase).to receive_message_chain(:errors, :full_messages) { "That's a no-no!" }
    expect(presenter.errors).to eq("That's a no-no!")
  end
end


