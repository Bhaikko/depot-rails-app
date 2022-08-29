class OrderMailer < ApplicationMailer
  # Setting default value for Mailer
  default from: 'Sam ruby <depot@example.com>'

  def received(order)
    @order = order
    order.line_items.each do |line_item|
      product = line_item.product
      product_images = product.images.to_a

      attachments.inline["#{product.title}_1"] = product_images.shift.download
      product.images do |image|
        attachments["#{product.name}_#{image.filename}"] = image.download
      end
    end

    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order shipped'
  end
end
