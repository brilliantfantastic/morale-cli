module Morale
  module Flow
    def retryable(options = {}, &block)
      opts = { :tries => 1, :indefinate => false, :on => Exception }.merge(options)

      retry_exception, retries, indefinately = opts[:on], opts[:tries], opts[:indefinate]

      begin
        return yield
      rescue retry_exception
        retry if indefinately || (retries -= 1) > 0
      end

      yield
    end
  end
end