require 'rails_helper'
require 'item_marketplace/presenters/items_index_presenter'

describe ItemsIndexPresenter do

  let(:tags) {double 'tags' }
  let(:items) { double 'items' }
  let(:presenter) { ItemsIndexPresenter.new(items, tags) }

  it "returns a collection of items" do

    expect(presenter.items).to eq(items)
  end

  it "returns a collection of tags" do

    expect(presenter.tags).to eq(tags)
  end
end
