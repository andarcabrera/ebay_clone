class NewPurchasePresenter

  attr_reader :purchase, :item

  def initialize(purchase, item)
    @purchase = purchase
    @item = item
  end

  def item_id
    @purchase.item_id
  end

  def purchaser_email
    @purchase.purchaser.email
  end

  def item_name
    @item.name
  end

  def item_buy_it_now_price
    @item.buy_it_now_price
  end

  def seller_email
    @item.seller.email
  end

  def errors
    @purchase.errors.full_messages
  end
end
