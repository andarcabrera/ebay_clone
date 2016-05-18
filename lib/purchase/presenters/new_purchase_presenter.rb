class NewPurchasePresenter

  attr_reader :purchase, :item

  def initialize(purchase, item)
    @purchase = purchase
    @item = item
  end

  def item_id
    @purchase.item_id
  end

  def buyer_email
    @purchase.email
  end

  def item_name
    @item.name
  end

  def item_price
    @item.price
  end

  def seller_email
    @item.email
  end
end
