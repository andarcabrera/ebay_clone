require 'rails_helper'

describe Purchase do
  let(:seller) { User.create(username: "Mr. Cheetos", email: "cheesy@cheese.com", password: "itainteastbeingcheesy") }
  let(:purchaser) { User.create(username: "Mr. Healthy", email: "salad@alot.com", password: "ilikecheese") }
  let (:item) { Item.create(name: "gloves", description: "they fit", buy_it_now_price: 89, seller_id: seller.id, auction_end_time: Time.now + 2.days, starting_bid_price: 2) }

  context "purchase is valid" do
    let (:purchase) { Purchase.create(purchaser_id: purchaser.id, item_id: item.id) }

    it "has a purchaser id" do

      expect(purchase.purchaser_id).to eq(purchaser.id)
    end

    it "has an item_id" do

      expect(purchase.item_id).to eq(item.id)
    end
  end

  context "purchase is invalid" do
    it "doesn't save without a purchaser id" do
      invalid_purchase = Purchase.create(item_id: item.id)

      expect(invalid_purchase.errors).to include(:purchaser_id)
    end

    it "doesn't save without an item id" do
      invalid_purchase = Purchase.create(purchaser_id: purchaser.id)

      expect(invalid_purchase.errors).to include(:item_id)
    end

    it "doesn't save if the item has already been purchased" do
      unavailable_item =  Item.create(name: "gloves", description: "they fit", buy_it_now_price: 89, seller_id: 1, available: false)
      invalid_purchase = Purchase.create(purchaser_id: purchaser.id, item_id: unavailable_item.id)

      expect(invalid_purchase.errors).to include(:available_item)
    end
  end
end
