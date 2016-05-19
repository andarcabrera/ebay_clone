require 'purchase/presenters/new_purchase_presenter'

class EbayMailerJob < ActiveJob::Base
  queue_as :default

  def perform(purchase, item)
    ItemSoldMailer.notify_seller(purchase, item).deliver_later
  end
end

