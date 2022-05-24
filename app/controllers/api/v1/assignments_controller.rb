class Api::V1::AssignmentsController < Api::V1::BaseController
  # Allow admin to assign a notification to a user // http://localhost:3000/api/v1/assignments, requires a user_id and a notification_id
  def create
    if current_user.admin?
      na = Assignment.new(assignment_params)
      if na.save
        render json: na, status: :created
      else
        render_error
      end
    else
      render_authorisation_error
    end
  end

  # http://localhost:3000/api/v1/assignments/check_read shows whether a user has read a notification; requries a user_id and a notification_id
  def check_read
    if current_user.admin?
      assignment_to_display = find_assignment
      render json: assignment_to_display, status: :ok
    else
      render_authorisation_error
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:user_id, :notification_id)
  end

  def find_assignment
    Assignment.where(user_id: params[:user_id], notification_id: params[:notification_id])
  end
end
