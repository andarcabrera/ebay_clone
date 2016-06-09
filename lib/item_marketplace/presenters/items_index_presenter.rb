class ItemsIndexPresenter

  attr_reader :items, :tags

  def initialize(items, tags = [])
    @items = items
    @tags = tags
  end
end
