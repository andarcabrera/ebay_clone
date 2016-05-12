require 'rails_helper'
require 'repository_container'

describe RepositoryContainer do
  it "get the correct item repo" do
    RepositoryContainer.add(:item, "MockRepo")

    expect(RepositoryContainer.get_repo(:item)).to eq("MockRepo")
  end

end

