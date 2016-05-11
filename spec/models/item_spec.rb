require 'rails_helper'

describe Item do

  before(:each) do
    Item.find_or_create_by(name: "socks", description: "they come in pairs", price: 10, email: "someone@gmail.com")
     @item = Item.first
  end

  after(:each) do
    Item.destroy_all
  end

  it "has a name" do

    expect(@item.name).to eq("socks")
  end

  it "has a description" do

    expect(@item.description).to eq("they come in pairs")
  end

  it "has a price" do

    expect(@item.price).to eq(10)
  end

  it "has an email" do

    expect(@item.email).to eq("someone@gmail.com")
  end

  it "doesn't save without a name" do
    item = Item.create(description: "Hi", price: 12, email: "hello")
    item.save
    item.valid?
    expect(item.errors).to include(:name)
  end

  it "doesn't save without a description" do
    item = Item.create(name: "Jerome", price: 12, email: "hello")
    item.save
    item.valid?
    expect(item.errors).to include(:description)
  end

  it "doesn't save without a price" do
    item = Item.create(name: "Jerome", description: "hot water", email: "hello")
    item.save
    item.valid?
    expect(item.errors).to include(:price)
  end

  it "doesn't save without a email" do
    item = Item.create(name: "Jerome", description: "hot water", price: 14)
    item.save
    item.valid?
    expect(item.errors).to include(:email)
  end
end
