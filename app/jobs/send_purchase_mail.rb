class SendPurchaseMail
  include Sidekiq::Worker

  def perform(purchase_id, item_id)
    purchase = Purchase.find(purchase_id)
    item = Item.find(item_id)
    ItemSoldMailer.notify_seller(purchase, item).deliver_now
  end
end

