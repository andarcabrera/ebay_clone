class NewItemPresenter

  attr_reader :item

  def initialize(item)
    @item = item
  end

  def errors
    @item.errors.full_messages
  end

  def tags_build
    @item.tags.build
  end
end
