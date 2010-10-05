require 'test_helper'

class LogTest < ActiveSupport::TestCase
  should validate_presence_of :ip_address
  should validate_presence_of :log
end
