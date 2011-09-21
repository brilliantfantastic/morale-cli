require 'webmock/cucumber'
require 'aruba/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
ENV['CREDENTIALS_LOCATION'] = "credentials"

Before('@interactive') do
  $stdout.sync = true
  $stdin.sync  = true
  @aruba_io_wait_seconds = 1
end