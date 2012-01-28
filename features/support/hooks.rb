include WebMock::API

Before do
  WebMock.disable_net_connect!(:allow_localhost => false)
  WebMock.reset!
end

Before('@interactive') do
  $stdout.sync = true
  $stdin.sync  = true
  @aruba_io_wait_seconds = 2
end