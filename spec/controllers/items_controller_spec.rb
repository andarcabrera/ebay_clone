require 'rails_helper'

describe ItemsController do

  after(:each) do
    Item.destroy_all
  end

  it "handles request to home page" do
    get :index

    expect(response).to have_http_status(:success)
    expect(response.content_type).to eq("text/html")
    expect(response).to render_template(:index)
  end

  it "handles request to go to create new item page" do
    get :new

    expect(response).to have_http_status(:success)
    expect(response.content_type).to eq("text/html")
    expect(response).to render_template(:new)
  end

  it "handles request to create new item" do
    post :create, :item => {name: "a", description: "A", price: 1, email: "a"}

    expect(response.content_type).to eq("text/html")
    expect(response).to redirect_to(:root)
    expect(Item.count).to eq(1)
  end

  it "handles request to create item with invalid params" do
    post :create, :item => {name: "", description: "A", price: 1, email: "a"}

    expect(response.content_type).to eq("text/html")
    expect(response).to render_template(:new)
    expect(Item.count).to eq(0)
  end
end

