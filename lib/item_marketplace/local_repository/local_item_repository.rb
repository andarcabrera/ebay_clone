require_relative 'local_item'

module LocalRepository
  class ItemRepository
    def initialize
      @items = {}
      @id = 1
    end

    def model_class
      LocalRepository::LocalItem
    end

    def new_item(item_details = {})
      model_class.new(item_details)
    end

    def save(item)
      item.id = @id
      if  item.valid?
        @items[@id] = item
        @id += 1
        item
      else
        false
      end
    end

    def all
      @items
    end

    def find_by(name)
      @items.values.find {|item| item.name == name[:name]}
    end

    def delete_all
      @items = {}
    end

  end
end
