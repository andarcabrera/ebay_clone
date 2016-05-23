require 'rails_helper'
require 'item_marketplace/presenters/new_item_presenter'

describe NewItemPresenter do

  let(:item) { double 'item' }
  let(:presenter) { NewItemPresenter.new(item) }

  it "returns a new item" do

    expect(presenter.item).to eq(item)
  end

   it "returns the error" do
    allow(item).to receive_message_chain(:errors, :full_messages) { "That's a no-no!" }

    expect(presenter.errors).to eq("That's a no-no!")
  end
end
