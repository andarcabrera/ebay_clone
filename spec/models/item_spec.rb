require 'rails_helper'

describe Item do
  it 'has a name' do

    Item.find_or_create_by(name: "socks", description: "they come in pairs", price: 10, email: "someone@gmail.com")

    expect(Item.first.name).to eq("socks")
  end
end
