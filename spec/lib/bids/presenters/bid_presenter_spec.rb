require 'rails_helper'
require 'bids/presenters/bid_presenter'

describe BidPresenter do

  let(:item) { double 'item', id: 2, name: "table" }
  let(:bid) { double 'bid', amount: 2, item: item }
  let(:presenter) { BidPresenter.new(bid) }

   it "returns the bid amount" do

     expect(presenter.amount).to eq(bid.amount)
   end

   it "returns the item name" do

     expect(presenter.name).to eq(item.name.capitalize)
   end
end
