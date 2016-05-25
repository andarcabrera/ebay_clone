require 'rails_helper'
require 'purchase/presenters/show_purchase_presenter'

describe ShowPurchasePresenter do

  let (:seller) { double "seller", id: 3, email: "hey@you.com" }
  let (:purchaser) { double "purchaser", id: 3, email: "areyouthere@email.com" }
  let (:purchase) { double "purchase", id: 3, purchaser: purchaser, purchaser_id: purchaser.id, item_id: item.id }
  let (:item) { double "item", id: 3, seller: seller, name: "phone", description: "smart", price: 3, seller_id: seller.id }
  let (:presenter) { ShowPurchasePresenter.new(purchase, item) }

  it "returns the purchase it's given" do

    expect(presenter.purchase).to eq(purchase)
  end

  it "returns the item it's given" do

    expect(presenter.item).to eq(item)
  end

  it "returns the buyer's email" do

    expect(presenter.purchaser_email).to eq("areyouthere@email.com")
  end

  it "returns the item name" do

    expect(presenter.item_name).to eq("phone")
  end

  it "return the seller's email" do

    expect(presenter.seller_email).to eq("hey@you.com")
  end

end


