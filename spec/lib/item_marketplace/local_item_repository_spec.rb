require_relative '../../../lib/item_marketplace/local_item_repository'

describe LocalRepository::LocalItemRepository do
  it 'builds plain_item objects' do
    repository = LocalRepository::LocalItemRepository.new

    expect(repository.model_class).to eq(LocalRepository::LocalItem)
  end

  it 'builds plain_item objects' do
    repository = LocalRepository::LocalItemRepository.new

    expect(repository.new).to be_instance_of(LocalRepository::LocalItem)
    expect(repository.new({})).to be_instance_of(LocalRepository::LocalItem)
  end


end

