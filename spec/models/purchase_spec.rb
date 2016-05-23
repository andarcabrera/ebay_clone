require 'rails_helper'

describe Purchase do
  let (:item) { Item.create(name: "gloves", description: "they fit", price: 89, email: "you@example.com") }
  context "purchase is valid" do
    let (:purchase) { Purchase.create(email: "me@example.com", item_id: item.id) }

    it "has an email" do

      expect(purchase.email).to eq("me@example.com")
    end

    it "has an item_id" do

      expect(purchase.item_id).to eq(item.id)
    end
  end

  context "item is invalid" do
    it "doesn't save without an email" do
      invalid_purchase = Purchase.create(item_id: item.id)

      expect(invalid_purchase.errors).to include(:email)
    end

    it "doesn't save without an item id" do
      invalid_purchase = Purchase.create(email: "us@example.com")

      expect(invalid_purchase.errors).to include(:item_id)
    end

    it "doesn't save if the item has already been purchased" do
      unavailable_item =  Item.create(name: "gloves", description: "they fit", price: 89, email: "you@example.com", available: false)
      invalid_purchase = Purchase.create(email: "me@example.com", item_id: unavailable_item.id)

      expect(invalid_purchase.errors).to include(:available_item)
    end
  end
end
