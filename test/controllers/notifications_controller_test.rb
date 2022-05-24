require 'test_helper'

class Api::V1::NotificationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test '#create - succesfull with admin user logged in' do
    sign_in_admin_user
    
    assert_difference 'Notification.count', 1 do
      post api_v1_notifications_path, params: {notification: { title: 'testTitle', description: 'testDescription', date: DateTime.now }}
    end

    assert_equal 'testTitle', Notification.last.reload.title
    assert_equal 'testDescription', Notification.last.description
  end

  test '#create - fails with non-admin user logged in' do
    sign_in_non_admin_user
    
    assert_no_difference 'Notification.count'  do
      post api_v1_notifications_path, params: {notification: { title: 'testTitle', description: 'testDescription', date: DateTime.now }}
    end

    assert_response :unauthorized  
  end
end
