class SendToPushServiceJob < ApplicationJob
  queue_as :default

  def perform(new_notification)
    puts 'Starting to send notificaton to push service'
    MockPushService.send(title: new_notification.title, description: new_notification.description,
                         token: 'some_unique_device_token')
    puts 'Notification sent successfully to Push Service 🟢'
  rescue MockPushService::Error => e
    puts "Send to Push Service failed 🔴, error: #{e.message}"
  end
end
