require 'purchase/presenters/new_purchase_presenter'

class ItemSoldMailer < ActionMailer::Base
  default from: "ebaycloneacjg@gmail.com"

  def notify_seller(purchase, item)
    @purchase_details = NewPurchasePresenter.new(purchase, item)
    mail(to: @purchase_details.seller_email, subject: "Item Sold")
  end
end

