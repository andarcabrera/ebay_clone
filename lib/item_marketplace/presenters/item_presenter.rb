class ItemPresenter
  attr_reader :item

  def initialize(item, bid = nil)
    @item = item
    @bid = bid
  end

  def errors
    if @bid
      @bid.errors.full_messages
    end
  end

  def id
    @item.id
  end

  def name
    @item.name.capitalize
  end

  def description
    @item.description
  end

  def buy_it_now_price
    @item.buy_it_now_price
  end

  def starting_bid_price
    @item.starting_bid_price
  end

  def highest_bid
    @item.highest_bid
  end

  def duration
    duration = (@item.auction_end_time - Time.now.utc).round
  end

  def days
    duration/86400
  end

  def hours
    (duration%86400)/3600
  end

  def minutes
    (duration%86400)%3600/60
  end

  def seconds
    duration%60
  end

  def auction_end_time
    @item.auction_end_time
  end

  def auction_ongoing
    auction_end_time && (auction_end_time - Time.now) >= 0
  end

  def tags
    @item.tags
  end
end
