require 'rails_helper'

describe PurchasesController do

  let (:item) { Item.create(name: "gloves", description: "they fit", price: 89, email: "you@example.com") }

  context "request to buy item" do

    it "response is successful" do
      get :new, :id => item.id

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the purchase template" do
      get :new, :id => item.id

      expect(response).to render_template(:new)
    end
  end

  context "purchase successful" do

    it "response successful" do
      post :create, :id => item.id, :purchase => {email: "someone@example.com", item_id: item.id}

      expect(response).to have_http_status(:redirect)
      expect(response.content_type).to eq("text/html")
    end

    it "redirects to the purchase confirmation page" do
      post :create, :id => item.id, :purchase => {email: "someone@example.com", item_id: item.id}

      expect(response).to redirect_to(action: "show", item_id: item.id, id: Purchase.last.id)
    end

    it "send a confirmation email to seller" do
      expect{ post :create, :id => item.id, :purchase => { email: "someone@example.com", item_id: item.id } }.to change{ActiveJob::Base.queue_adapter.enqueued_jobs.count}.by(1)
    end
  end

  context "purchase unsuccessful" do

    it "renders purchase form page" do
      post :create, :id => item.id, :purchase => { item_id: item.id }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end
  end

end
