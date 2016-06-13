require 'rails_helper'
require 'tags/presenters/tag_presenter'

describe TagPresenter do

  let(:tag) { double 'tag', id: 3, name: "pocahontas", items: ["hello", "good_bye"] }
  let(:presenter) { TagPresenter.new(tag) }

  it "returns a tag" do

    expect(presenter.tag).to eq(tag)
  end

   it "returns the error" do
    allow(tag).to receive_message_chain(:errors, :full_messages) { "That's a no-no!" }

    expect(presenter.errors).to eq("That's a no-no!")
  end

   it "returns the tag id" do

    expect(presenter.id).to eq(tag.id)
   end

   it "returns the tag name" do

    expect(presenter.name).to eq(tag.name)
   end

   it "returns the items associated with the tag" do

     expect(presenter.items).to eq(tag.items)
   end
end
