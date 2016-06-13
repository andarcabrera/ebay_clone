class CreateItem

  attr_reader :item_params, :tag_names, :current_user
  def initialize(item_params, current_user=nil, tag_names=nil)
    @item_params = item_params
    @current_user = current_user
    @tag_names = tag_names
  end

  def call
    item = Item.new(item_params)
    item.seller_id = current_user.id
    if item.valid?
      item.save
      create_tags(item)
      if item.auctioned?
        AuctionWorker.perform_in(auction_duration(item), item.id)
      end
    end
    item
  end

  private

  def create_tags(item)
    if tag_names
      tag_names.each do |name|
        tag = Tag.find_or_create_by(name: name)
        item.tags << tag
      end
    end
  end

  def auction_duration(item)
    item.auction_end_time - Time.now.utc
  end
end
