require 'rails_helper'

describe ItemsController do
  it "calls the index action" do
    controller = ItemsController.new

    get :index
    expect(response).to have_http_status(:success)
    expect(response.content_type).to eq("text/html")
    expect(response).to render_template(:index)
  end

  it "calls the new action" do

    get :create
    expect(response).to have_http_status(:success)
  end

  it "calls the new action" do

    post :create
    expect(response).to have_http_status(:success)
  end

  it "creates a new item" do
    post :create, :item => {name: "a", description: "A", price: 1, email: "a"}

    expect(response.content_type).to eq("text/html")
  end
end

