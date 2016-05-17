require 'rails_helper'

describe PurchasesController do

  context "request to buy item" do
    before do
      @item =  Item.create(name: "gloves", description: "they fit", price: 89, email: "you@example.com")
    end

    it "response is successful" do
      get :new, :id => @item.id

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the purchase template" do
      get :new, :id => @item.id

      expect(response).to render_template(:new)
    end
  end

  context "purchase successful" do
    before do
      @item =  Item.create(name: "gloves", description: "they fit", price: 89, email: "you@example.com")
    end

    it "response successful" do
      post :create, :purchase => {email: "someone@example.com", item_id: @item.id}

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders to the purchase confirmation page" do
      post :create, :purchase => {email: "someone@example.com", item_id: @item.id}

      expect(response).to render_template(:show)
    end

    it "send a confirmation email to seller" do
      expect{post :create, :purchase => {email: "someone@example.com", item_id: @item.id}}.to change{ActionMailer::Base.deliveries.count}.by(1)
    end
  end

  context "purchase unsuccessful" do
    before do
      @item =  Item.create(name: "gloves", description: "they fit", price: 89, email: "you@example.com")
    end

    it "redirects to new purchase  page" do
      post :create, :purchase => { item_id: @item.id }

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end
  end

end
