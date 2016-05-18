class ItemSoldMailer < ActionMailer::Base
  default from: "ebaycloneacjg@gmail.com"

  def notify_seller(purchase_details)
    @purchase_details = purchase_details
    mail(to: @purchase_details.seller_email, subject: "Item Sold")
  end
end

