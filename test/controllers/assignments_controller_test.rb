module Api
  module V1
    class AssignmentsControllerTest < ActionDispatch::IntegrationTest
    
      test '#create' do
        #TODO use factory
        user_id = 1
        notification_id = 2

        assert_difference 'Assignment.count', 1 do
          post api_v1_assignments_path, params: {assignment: { user_id: user_id, notification_id: notification_id}}
        end

        assert_equal Assignment.last.user_id, 1
        assert_equal Assignment.last.notificaion_id, 2
      end

    end
  end
end
