require 'webmock'
require 'webmock/cucumber'
require 'aruba/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
ENV['CREDENTIALS_LOCATION'] = "credentials"
ENV['CONNECTION_LOCATION'] = "connection"
ENV['DEFAULT_BASE_URL'] = "lvh.me:3000"
