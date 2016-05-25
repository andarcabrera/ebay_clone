require 'rails_helper'

describe Item do
  context "item is valid" do
    let(:seller) { User.create(username: "Mr. Cheetos", email: "cheesy@cheese.com", password: "itainteastbeingcheesy") }
    let(:item) { Item.create(name: "socks", description: "they come in pairs", price: 10, seller_id: seller.id) }

    it "has a name" do

      expect(item.name).to eq("socks")
    end

    it "has a description" do

      expect(item.description).to eq("they come in pairs")
    end

    it "has a price" do

      expect(item.price).to eq(10)
    end

    it "has an seller_id" do

      expect(item.seller_id).to eq(seller.id)
    end

    it "has availablity" do

      expect(item.available).to eq(true)
    end
  end

  context "item is invalid" do
    let(:seller) { User.create(username: "Mr. Cheetos", email: "cheesy@cheese.com", password: "itainteastbeingcheesy") }

    it "doesn't save without a name" do
      item = create_invalid_item(description: "Hi", price: 12, seller_id: seller.id)

      expect(item.errors).to include(:name)
    end

    it "doesn't save without a description" do
      item = create_invalid_item(name: "Jerome", price: 12, seller_id: seller.id)

      expect(item.errors).to include(:description)
    end

    it "doesn't save without a price" do
      item = create_invalid_item(name: "Jerome", description: "hot water", seller_id: seller.id)

      expect(item.errors).to include(:price)
    end

    it "doesn't save without a seller_id" do
      item = create_invalid_item(name: "Jerome", description: "hot water", price: 14)
      expect(item.errors).to include(:seller_id)
    end
  end

  private

  def create_invalid_item(item_details)
    item = Item.create(item_details)
  end
end
