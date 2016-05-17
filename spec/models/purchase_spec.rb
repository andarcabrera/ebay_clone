require 'rails_helper'

describe Purchase do

  before(:each) do
    Purchase.create(email: "me@example.com", item_id: 2)
    @purchase = Purchase.first
  end

  context "purchase is valid" do
    it "has an email" do

      expect(@purchase.email).to eq("me@example.com")
    end

    it "has an item_id" do

      expect(@purchase.item_id).to eq(2)
    end
  end

  context "item is invalid" do
    it "doesn't save without an email" do
      purchase = create_invalid_purchase(item_id: 1)

      expect(purchase.errors).to include(:email)
    end

    it "doesn't save without an item id" do
      purchase = create_invalid_purchase(email: "us@example.com")

      expect(purchase.errors).to include(:item_id)
    end
  end


  private

  def create_invalid_purchase(purchase_details)
    Purchase.create(purchase_details)
  end
end
