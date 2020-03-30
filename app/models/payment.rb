class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :story

  def paypal_url(return_path)
    values = {
      business: ENV["EMAIL_BUSSINESS"],
      cmd: Settings.payment.cmd,
      upload: Settings.payment.upload,
      return: "#{Settings.payment.app_host}#{return_path}",
      invoice: id,
      amount: story.price,
      item_name: story.name,
      item_number: story.id,
      quantity: Settings.payment.quantity,
      notify_url: "#{Settings.payment.app_host}/hook"
    }
    "#{Settings.payment.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
