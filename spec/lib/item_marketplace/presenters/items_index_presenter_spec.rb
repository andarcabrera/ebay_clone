require 'rails_helper'
require 'item_marketplace/presenters/items_index_presenter'

describe ItemsIndexPresenter do

  let(:items) { double 'items'}

  it "returns a collection of items" do
    presenter = ItemsIndexPresenter.new(items)

    expect(presenter.items).to eq(items)
  end

end

