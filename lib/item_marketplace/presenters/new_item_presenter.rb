class NewItemPresenter

  attr_reader :item

  def initialize(item)
    @item = item
  end

  def errors
    @item.errors
  end
end
