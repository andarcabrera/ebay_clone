require_relative '../../../lib/item_marketplace/local_item_repository'

describe LocalRepository::LocalItemRepository do

  let (:repository) {LocalRepository::LocalItemRepository.new}

  it 'builds plain_item objects' do

    expect(repository.model_class).to eq(LocalRepository::LocalItem)
  end

  it 'builds plain_item objects' do

    expect(repository.new).to be_instance_of(LocalRepository::LocalItem)
    expect(repository.new({})).to be_instance_of(LocalRepository::LocalItem)
  end

  it 'saves items locally' do
    item = repository.new({name: "pen"})
    repository.save(item)

    expect(repository.all.count).to eq(1)
  end

  it 'finds an item based by id' do
    item = repository.new({name: "pen"})
    item1 = repository.new({name: "pencil"})
    repository.save(item)
    repository.save(item1)

    expect(repository.find_by(2)).to eq(item1)
  end

end

