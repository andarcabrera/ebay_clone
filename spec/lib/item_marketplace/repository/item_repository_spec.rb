require 'item_marketplace/local_repository/local_item_repository'
require 'item_marketplace/active_record_repository/active_record_item_repository'

shared_examples_for "item repositories" do
  let(:repository) { described_class.new }
  let(:item1) { repository.new_item({name: "shades", description: "cool", price: 100, email: "cool@cool.com"})}
  let(:item2) { repository.new_item({name: "shades2", description: "cool", price: 100, email: "cool@cool.com"})}

  it 'saves items locally' do
    repository.save(item1)

    expect(repository.all.count).to eq(1)
  end

  it 'finds an item based by id' do
    repository.save(item1)
    repository.save(item2)

    expect(repository.find_by(2)).to eq(item2)
  end

end

describe LocalRepository::ItemRepository do
  it_behaves_like "item repositories"
end

describe ActiveRecordRepository::ItemRepository do
  it_behaves_like "item repositories"
end

