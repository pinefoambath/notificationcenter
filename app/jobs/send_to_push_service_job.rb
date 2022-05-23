class SendToPushServiceJob < ApplicationJob
  queue_as :default

  def perform(new_notification)
    begin
      puts "Starting to send notificaton to push service"
     
      MockPushService.send(title: new_notification.title, description: new_notification.description, token: "some_unique_device_token")
     
      puts "Notification sent successfully to push Service 🟢"
    rescue MockPushService::Error => e
      puts "Send to push service failed 🔴, error: #{e.message}"
    end
  end
end
