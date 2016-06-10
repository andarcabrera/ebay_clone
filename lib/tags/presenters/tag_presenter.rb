class TagPresenter

  attr_reader :tag

  def initialize(tag)
    @tag = tag
  end

  def errors
    @tag.errors.full_messages
  end

  def id
    @tag.id
  end

  def name
    @tag.name
  end

  def items
    @tag.items
  end
end
