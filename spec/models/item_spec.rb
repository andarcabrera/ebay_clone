require 'rails_helper'

describe Item do

  before(:each) do
     Item.find_or_create_by(name: "socks", description: "they come in pairs", price: 10, email: "someone@gmail.com")
     @item = Item.first
  end

  after(:each) do
    Item.destroy_all
  end

  it 'has a name' do

    expect(@item.name).to eq("socks")
  end

  it 'has a description' do

    expect(@item.description).to eq("they come in pairs")
  end

  it 'has a price' do

    expect(@item.price).to eq(10)
  end

  it 'has an email' do

    expect(@item.email).to eq("someone@gmail.com")
  end
end
