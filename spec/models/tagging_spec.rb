require 'rails_helper'

describe Tagging do
  let (:seller) { User.create(username: "Mr. Cheetos", email: "cheesy@cheese.com", password: "itainteastbeingcheesy") }
  let (:item) { Item.create(name: "gloves", description: "they fit", buy_it_now_price: 89, seller_id: seller.id, auction_end_time: Time.now + 2.days, starting_bid_price: 2) }
  let (:tag) { Tag.create(name: "fun") }

  context "tagging is valid" do
    let (:tagging) { Tagging.create(item_id: item.id, tag_id: tag.id) }

    it "has an item id" do

      expect(tagging.item_id).to eq(item.id)
    end

    it "has a tag id" do

      expect(tagging.tag_id).to eq(tag.id)
    end
  end

  context "tagging is invalid" do
    it "doesn't save without an item id" do
      invalid_tagging = Tagging.create(tag_id: tag.id)

      expect(invalid_tagging.errors).to include(:item_id)
    end

    it "doesn't save without a tag id" do
      invalid_tagging = Tagging.create(item_id: item.id)

      expect(invalid_tagging.errors).to include(:tag_id)
    end
  end
end
