require "rails_helper"
require "spec_helper"

describe ItemSoldMailer do
  let (:seller) { double "seller", id: 3, email: "hey@you.com" }
  let (:purchaser) { double "purchaser", id: 3, email: "areyouthere@email.com" }
  let (:purchase) { double "purchase", id: 3, purchaser: purchaser, purchaser_id: purchaser.id, item_id: item.id }
  let (:item) { double "item", id: 3, seller: seller, name: "phone", description: "smart", buy_it_now_price: 3, seller_id: seller.id }
  let (:presenter) { NewPurchasePresenter.new(purchase, item) }
  let(:mail) { described_class.notify_seller(purchase, item).deliver_now }
  let(:auction_mail) { described_class.notify_after_auction(purchase, item).deliver_now }

  context "seller is notified" do
    it "it has a subject" do

      expect(mail.subject).to eq("Item Sold")
    end

    it "it is sent to the item's seller email" do

      expect(mail.to).to eq(["hey@you.com"])
    end

    it "it is sent from the ebay_clone default email" do

      expect(mail.from).to eq(["ebaycloneacjg@gmail.com"])
    end

    it "the body of the email contains the email of the buyer" do

      expect(mail.body).to include(purchase.purchaser.email)
    end

    it "the body of the email contains the item details" do

      expect(mail.body).to include(item.name)
      expect(mail.body).to include(item.buy_it_now_price)
    end
  end

  context "winning bidder is notified" do
    it "it has a subject" do

      expect(auction_mail.subject).to eq("Auction over. You won!")
    end

    it "it is sent to the winning bidder's email" do

      expect(auction_mail.to).to eq(["areyouthere@email.com"])
    end

    it "it is sent from the ebay_clone default email" do

      expect(auction_mail.from).to eq(["ebaycloneacjg@gmail.com"])
    end

    it "the body of the email contains the email of the seller" do

      expect(auction_mail.body).to include(seller.email)
    end

    it "the body of the email contains the item details" do

      expect(auction_mail.body).to include(item.name)
    end
  end

end
