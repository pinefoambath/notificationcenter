class Api::V1::NotificationsController < Api::V1::BaseController
  def index
    @notifications = Notification.all.order('created_at ASC')
  end

  #As admin, I can create a notification with a date, title and description, via a POST request to /api/v1/notifications 
  def create
    new_notification = Notification.new(notification_params)
    if new_notification.save
      render json: new_notification, status: :created
    else
      render_error
    end
  end

  def update
    notification_to_update = Notification.find(params[:id])
    if notification_to_update.update(update_params)
      render json: notification_to_update, status: :updated
    else
      render :new
    end
  end

  private
  def notification_params
    params.require(:notification).permit(:title, :description, :date, assignment_ids: [])
  end


  def render_error
    render json: { errors: @notification.errors.full_messages },
      status: :unprocessable_entity
  end

end
