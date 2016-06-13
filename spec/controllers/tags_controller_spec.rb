require 'rails_helper'

describe TagsController do
  let(:tag) { Tag.create(name: "yummy") }

  context "show page is requested" do
    it "a valid tag is requested" do
      get :show, :id => tag.id

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("text/html")
    end

    it "renders the show template" do
      get :show, :id => tag.id

      expect(response).to render_template(:show)
    end
  end

  context "an invalid tag is requested" do
    it "renders a 404 page" do
      get :show, :id => -1

      expect(response).to have_http_status(:not_found)
      expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
    end
  end
end
