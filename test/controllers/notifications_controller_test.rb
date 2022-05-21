module Api
  module V1
    class NotificationsControllerTest < ActionDispatch::IntegrationTest
      
      test '#index' do
        get api_v1_notifications_path
    
        assert_response :success
      end

      test '#create' do
        assert_difference 'Notification.count', 1 do
          post api_v1_notifications_path, params: {notification: { title: 'testTitle', description: 'testDescription', date: DateTime.now }}
        end

        assert_equal 'testTitle', Notification.last.reload.title
        assert_equal 'testDescription', Notification.last.description
      end

    end
  end
end

