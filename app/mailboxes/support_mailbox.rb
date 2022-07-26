class SupportMailbox < ApplicationMailbox
  # Every email received at this route will trigger process method
  def process
    puts "START SupportMailbox#process:"
    puts "From: #{mail.from_address}"
    puts "Subject: #{mail.subject}"
    puts "Body: #{mail.body}"
    puts "END SupportMailbox#process:"
  end
end
