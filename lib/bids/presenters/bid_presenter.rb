class BidPresenter

  attr_reader :item, :bid

  def initialize(bid)
    @bid = bid
  end

  def name
    @bid.item.name.capitalize
  end

  def amount
    @bid.amount
  end
end
