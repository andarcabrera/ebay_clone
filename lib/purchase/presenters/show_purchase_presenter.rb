class ShowPurchasePresenter

  attr_reader :purchase, :item

  def initialize(purchase, item)
    @purchase = purchase
    @item = item
  end

  def purchaser_email
    @purchase.purchaser.email
  end

  def item_name
    @item.name
  end

  def seller_email
    @item.seller.email
  end
end
