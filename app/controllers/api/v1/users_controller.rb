class Api::V1::UsersController < Api::V1::BaseController
  
  #As a client, I want to be able to view my notifications 
  def show
    @user = User.find(params[:id])
    notifications = @user.notifications.order('created_at ASC')
    render :json => {:notifications => notifications}
    flag_as_read
  end

  private

  def flag_as_read
    @user.assignments.each do |assignment|
      assignment.update(read: true)
    end
  end

end