class ShowPurchasePresenter

  attr_reader :purchase, :item

  def initialize(purchase, item)
    @purchase = purchase
    @item = item
  end

  def buyer_email
    @purchase.email
  end

  def item_name
    @item.name
  end

  def seller_email
    @item.email
  end
end
