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
end
