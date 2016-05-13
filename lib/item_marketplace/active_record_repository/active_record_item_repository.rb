require 'item_marketplace/active_record_repository/item'

module ActiveRecordRepository
  class ItemRepository
    def model_class
      ActiveRecordRepository::Item
    end

    def new_item(item_details = {})
      puts item_details
      model_class.new(item_details)
    end

    def save(item)
      item.save
    end

    def all
      model_class.all
    end

    def find_by(name)
      model_class.find_by(name)
    end

  end
end

