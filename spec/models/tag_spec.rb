require 'rails_helper'

describe Tag do
  context "tag is valid" do
    let (:tag) { Tag.create(name: "fun") }

    it "has a name" do

      expect(tag.name).to eq("fun")
    end
  end

  context "tag is invalid" do
    it "doesn't save without a name" do
      invalid_tag = Tag.create()

      expect(invalid_tag.errors).to include(:name)
    end
  end
end
