namespace :order do
  desc 'Sends all of the users a consolidated email of all his/her orders and items'
  task :send_order_details => :environment do
    Order.all.each { |order| OrderMailer.received(order) }
  end
end