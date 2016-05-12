require 'item_marketplace/active_record_repository/item'

module ActiveRecordRepository
  class ItemRepository
    def initialize
      @items = {}
      @id = 1
    end

    def model_class
      ActiveRecordRepository::Item
    end

    def new_item(item_details = {})
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

