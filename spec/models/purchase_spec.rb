require 'rails_helper'

describe Purchase do

  let (:purchase) { Purchase.create(email: "me@example.com", item_id: 2) }

  context "purchase is valid" do
    it "has an email" do

      expect(purchase.email).to eq("me@example.com")
    end

    it "has an item_id" do

      expect(purchase.item_id).to eq(2)
    end
  end

  context "item is invalid" do
    it "doesn't save without an email" do
      invalid_purchase = Purchase.create(item_id: 1)

      expect(invalid_purchase.errors).to include(:email)
    end

    it "doesn't save without an item id" do
      invalid_purchase = Purchase.create(email: "us@example.com")

      expect(invalid_purchase.errors).to include(:item_id)
    end
  end
end
