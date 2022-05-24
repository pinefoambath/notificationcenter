ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def sign_in_admin_user
    admin_user = users(:admin_user)
    sign_in admin_user
    admin_user
  end

  def sign_in_non_admin_user
    non_admin_user = users(:john)
    sign_in non_admin_user
    non_admin_user
  end
end
