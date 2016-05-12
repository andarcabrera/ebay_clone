require_relative 'local_item'

module LocalRepository
  class LocalItemRepository
    def initialize
      @items = {}
      @id = 1
    end

    def model_class
      LocalRepository::LocalItem
    end

    def new(item_details = {})
      model_class.new(item_details)
    end

    def save(item)
      item.id = @id
      @items[@id] = item
      @id += 1
    end

    def all
      @items
    end

    def find_by(item_id)
      @items[item_id]
    end
  end
end
