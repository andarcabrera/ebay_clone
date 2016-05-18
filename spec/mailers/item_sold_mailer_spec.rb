require 'rails_helper'
require 'spec_helper'

describe ItemSoldMailer do
  context 'an item is sold' do
    let(:purchase_details) { double 'purchase_details', buyer_email: 'sternmother@email.com', item_name: "pool noodle", item_price: 4, seller_email: "seller@me.com", item_id: 1 }
    let(:mail) { described_class.notify_seller(purchase_details).deliver_now }

    it 'it has a subject' do
      expect(mail.subject).to eq('Item Sold')
    end

    it 'it is sent to the item\'s seller email' do

      expect(mail.to).to eq(["seller@me.com"])
    end

    it 'it is sent from the ebay_clone default email' do

      expect(mail.from).to eq(['ebaycloneacjg@gmail.com'])
    end

    it 'the body of the email contains the email of the buyer' do

      expect(mail.body).to include(purchase_details.buyer_email)
    end

    it 'the body of the email contains the item details' do

      expect(mail.body).to include(purchase_details.item_name)
      expect(mail.body).to include(purchase_details.item_price)
    end
  end
end

