module Api
  module V1
    class AssignmentsControllerTest < ActionDispatch::IntegrationTest
      include Devise::Test::IntegrationHelpers

      test '#show' do
        user_john = users(:john)
        user_id = user_john.id
        new_notification = Notification.create(title: 'testTitle', description: 'testDescription', date: DateTime.now)
        new_assignment = Assignment.create(notification_id: new_notification.id, user_id: user_id)
        get api_v1_assignment_path, params: {user_id: user_id, notification_id: new_notification.id}
       
        assert_response :success
      end

      test '#create' do
   
        user_john = users(:john)
        sign_in user_john
        new_notification = Notification.create(title: 'testTitle', description: 'testDescription', date: DateTime.now)

        user_id = user_john.id
        notification_id = new_notification.id

        assert_difference 'Assignment.count', 1 do
          post api_v1_assignments_path, params: {assignment: { user_id: user_id, notification_id: notification_id}}
        end

        assert_equal Assignment.last.user_id, user_id
        assert_equal Assignment.last.notification_id, new_notification.id
      end

    end
  end
end



