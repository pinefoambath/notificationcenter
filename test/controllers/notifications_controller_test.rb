module Api
  module V1
    class NotificationsControllerTest < ActionDispatch::IntegrationTest
      include Devise::Test::IntegrationHelpers

      test '#create - succesfull with admin user logged in' do
        user_admin = users(:admin_user)
        sign_in user_admin
       
        assert_difference 'Notification.count', 1 do
          post api_v1_notifications_path, params: {notification: { title: 'testTitle', description: 'testDescription', date: DateTime.now }}
        end

        assert_equal 'testTitle', Notification.last.reload.title
        assert_equal 'testDescription', Notification.last.description
      end

      test '#create - fails with non-admin user logged in' do
        non_admin_user = users(:john)
        sign_in non_admin_user
       
        assert_no_difference 'Notification.count'  do
          post api_v1_notifications_path, params: {notification: { title: 'testTitle', description: 'testDescription', date: DateTime.now }}
        end

        assert_response :unauthorized  
      end

    end
  end
end

