require 'rails_helper'
require 'item_marketplace/presenters/new_item_presenter'

describe NewItemPresenter do

  let(:item) { double 'item' , errors: "you wrong" }
  let(:presenter) { NewItemPresenter.new(item) }

  it "returns a new item" do

    expect(presenter.item).to eq(item)
  end

   it "returns the error" do

    expect(presenter.errors).to eq("you wrong")
  end
end
