require 'rails_helper'
require 'purchase/presenters/new_purchase_presenter'

describe NewPurchasePresenter do

  let (:purchase) { double "purchase", email: "areyouthere@email.com", item_id: 3, errors: "that's a no-no!" }
  let (:item) { double "item", name: "phone", description: "smart", price: 3, email: "hey@you.com" }
  let (:presenter) { NewPurchasePresenter.new(purchase, item) }

  it "returns the purchase it's given" do

    expect(presenter.purchase).to eq(purchase)
  end

  it "returns the item it's given" do

    expect(presenter.item).to eq(item)
  end

  it "return the item_id" do

    expect(presenter.item_id).to eq(3)
  end

  it "returns the buyer's email" do

    expect(presenter.buyer_email).to eq("areyouthere@email.com")
  end

  it "returns the item name" do

    expect(presenter.item_name).to eq("phone")
  end

  it "returns item price" do

    expect(presenter.item_price).to eq(3)
  end

  it "return the seller's email" do

    expect(presenter.seller_email).to eq("hey@you.com")
  end

  it "returns an error for invalid purchase" do

    expect(presenter.errors).to eq("that's a no-no!")
  end
end


