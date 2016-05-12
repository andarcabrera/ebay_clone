require_relative 'local_item'

module LocalRepository
  class LocalItemRepository
    def model_class
      LocalRepository::LocalItem
    end

    def new(item_details = {})
      model_class.new(item_details)
    end
  end
end
