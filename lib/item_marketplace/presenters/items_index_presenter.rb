class ItemsIndexPresenter

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def available_items
    @items.select {|item| item.available == true}
  end
end
