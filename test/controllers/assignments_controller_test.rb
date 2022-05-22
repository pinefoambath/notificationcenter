module Api
  module V1
    class AssignmentsControllerTest < ActionDispatch::IntegrationTest
      include Devise::Test::IntegrationHelpers

      test '#check_read - works for admin user' do
        user_admin = users(:admin_user)
        sign_in user_admin
        user_id = user_admin.id
        new_notification = Notification.create(title: 'testTitle', description: 'testDescription', date: DateTime.now)
        new_assignment = Assignment.create(notification_id: new_notification.id, user_id: user_id)
        get api_v1_assignments_check_read_path, params: {user_id: user_id, notification_id: new_notification.id}
       
        assert_response :success
      end


      test '#check_read - non-admin users cannot access read status' do
        non_admin_user = users(:john)
        sign_in non_admin_user
        user_id = non_admin_user.id
        new_notification = Notification.create(title: 'testTitle', description: 'testDescription', date: DateTime.now)
        new_assignment = Assignment.create(notification_id: new_notification.id, user_id: user_id)
        get api_v1_assignments_check_read_path, params: {user_id: user_id, notification_id: new_notification.id}
       
        assert_response :unauthorized
      end

      test '#create - admin user can create new assignments' do
   
        user_admin = users(:admin_user)
        sign_in user_admin
        new_notification = Notification.create(title: 'testTitle', description: 'testDescription', date: DateTime.now)

        user_id = user_admin.id
        notification_id = new_notification.id

        assert_difference 'Assignment.count', 1 do
          post api_v1_assignments_path, params: {assignment: { user_id: user_id, notification_id: notification_id}}
        end

        assert_equal Assignment.last.user_id, user_id
        assert_equal Assignment.last.notification_id, new_notification.id
      end

      test '#create - non-admin users cannot create new assignments' do
   
        non_admin_user = users(:john)
        sign_in non_admin_user
        new_notification = Notification.create(title: 'testTitle', description: 'testDescription', date: DateTime.now)

        user_id = non_admin_user.id
        notification_id = new_notification.id

        assert_no_difference 'Assignment.count'  do
          post api_v1_assignments_path, params: {assignment: { user_id: user_id, notification_id: notification_id}}
        end

        assert_response :unauthorized

      end

    end
  end
end



