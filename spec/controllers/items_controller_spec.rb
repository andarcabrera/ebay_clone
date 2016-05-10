require 'rails_helper'

describe ItemsController do
  it "calls the index action" do
    controller = ItemsController.new

    get :index
    expect(response).to have_http_status(:success)
  end

  it "calls the new action" do

    get :create
    expect(response).to have_http_status(:success)
  end

  it "calls the new action" do

    post :create
    expect(response).to have_http_status(:success)
  end
end

