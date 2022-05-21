class Api::V1::AssignmentsController < Api::V1::BaseController

  # http://localhost:3000/api/v1/assignments/:id shows whether a user has read a notification
  def show
    @assignment = Assignment.find(params[:id])
    render :json => @assignment
  end

  # Allow admin to assign a notification to a user // http://localhost:3000/api/v1/assignments
  def create
    na = Assignment.new(assignment_params)
    if na.save
      render json: na, status: :created
    else
      render_error
    end
  end
  
  private

  def assignment_params
    params.require(:assignment).permit(:user_id, :notification_id)
  end
User
  def render_error
    render json: { errors: @notification.errors.full_messages },
      status: :unprocessable_entity
  end
  
end