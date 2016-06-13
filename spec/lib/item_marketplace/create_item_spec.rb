require 'item_marketplace/create_item'
require 'rails_helper'

describe CreateItem do
  let(:current_user) { User.create(username: "dreamteam", email: "us@dream.com", password_hash: "zzzzzzz") }
  let(:tag_names)   { ["fun", "agile"] }
  let(:item_params) { {name: "ping-pong paddle",
                       description: "you beat Alex with it",
                       buy_it_now_price: 1,
                       seller_id: current_user.id} }
  let(:invalid_item_params) { {description: "you beat Alex with it",
                          buy_it_now_price: 1,
                          seller_id: current_user.id} }

  context "item is created succesfully" do
    let(:create_item) { CreateItem.new(item_params, current_user, tag_names) }

    it "returns the item" do

      expect(create_item.call).to eq(Item.last)
    end

    it "it saves the item in the database" do
      create_item.call

      expect(Item.last.name).to eq("ping-pong paddle")
      expect(Item.last.seller_id).to eq(current_user.id)
    end

    it "creates tag for the item" do
      create_item.call

      expect(Item.last.tags.count).to eq(2)
      expect(Item.last.tags[0].name).to eq("fun")
    end
  end

  context "item is not created succesfully" do
    let(:create_invalid_item) { CreateItem.new(invalid_item_params, current_user, tag_names) }

    it "return nil upon failing to create the item" do
      item = create_invalid_item.call

      expect(item.valid?).to be false
    end

    it "does not save item to database" do
      create_invalid_item.call

      expect(Item.count).to eq(0)
    end
  end
end
