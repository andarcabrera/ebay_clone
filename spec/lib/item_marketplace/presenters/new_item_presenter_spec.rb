require 'rails_helper'
require 'item_marketplace/presenters/new_item_presenter'

describe NewItemPresenter do

  let(:item) { double 'item' }

  it "returns a new item" do
    presenter = NewItemPresenter.new(item)

    expect(presenter.item).to eq(item)
  end
end
