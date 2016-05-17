require 'rails_helper'
require 'spec_helper'

describe ItemSoldMailer do
  context 'an item is sold' do
    let(:item) { double 'item', name: 'pool noodle', description: 'whack people with it', email: 'annoyingkid@email.com' }
    let(:purchase) { double 'purchase', email: 'sternmother@email.com', item_id: 1 }
    let(:mail) { described_class.notify_seller(item, purchase).deliver_now }

    it 'it has a subject' do
      expect(mail.subject).to eq('Item Sold')
    end

    it 'it is sent to the item\'s seller email' do

      expect(mail.to).to eq([item.email])
    end

    it 'it is sent from the ebay_clone default email' do

      expect(mail.from).to eq(['ebaycloneacjg@gmail.com'])
    end

    xit 'the body of the email contains the email of the buyer' do

      expect(mail.body).to include(purchase.email)
    end

    xit 'the body of the email contains the item details' do

      expect(mail.body).to include(item.name)
      expect(mail.body).to include(item.price)
    end


    xit 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to match("http://aplication_url/#{user.id}/confirmation")
    end
  end
end

