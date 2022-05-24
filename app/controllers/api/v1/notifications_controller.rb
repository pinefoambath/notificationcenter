class Api::V1::NotificationsController < Api::V1::BaseController
  # As admin, I can create a notification with a date, title and description, via a POST request to /api/v1/notifications; if successful the page will send back a json of the new notification object
  def create
    if current_user.admin?
      new_notification = Notification.new(notification_params)
      if new_notification.save
        SendToPushServiceJob.perform_later(Notification.last)
        render json: new_notification, status: :created
      else
        render_error
      end
    else
      render_authorisation_error
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:title, :description, :date, assignment_ids: [])
  end
end
