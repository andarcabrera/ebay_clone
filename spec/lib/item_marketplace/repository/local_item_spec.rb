require 'item_marketplace/local_repository/local_item'
require 'rails_helper'

describe LocalRepository::LocalItem do
  before(:each) do
   @item = LocalRepository::LocalItem.new({name: "lamp", description: "light up", price: "500", email: "email@email.com", image: "image_path"})
  end
  it "has a name" do

    expect(@item.name).to eq("lamp")
  end

  it "has a description" do

    expect(@item.description).to eq("light up")
  end

  it "has a price" do

    expect(@item.price).to eq("500")
  end

  it "has a email" do

    expect(@item.email).to eq("email@email.com")
  end

  it "has a image" do

    expect(@item.image).to eq("image_path")
  end
end
