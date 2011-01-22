require 'test_helper'

class LogsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  context "index" do
    setup do
      get(:index)
    end
    should respond_with :success
    #should assign_to :logs
  end
end
