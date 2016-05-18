require 'rails_helper'
require 'item_marketplace/presenters/items_index_presenter'

describe ItemsIndexPresenter do

  let(:available_item) { double 'available_item', available: true }
  let(:unavailable_item) { double 'unavailable_item', available: false }
  let(:items) { [available_item, unavailable_item] }
  let(:presenter) { ItemsIndexPresenter.new(items) }

  it "returns a collection of items" do

    expect(presenter.items).to eq(items)
  end

  it "returns available items" do

    expect(presenter.available_items).to eq([available_item])
    expect(presenter.available_items).to_not include(unavailable_item)
  end
end
