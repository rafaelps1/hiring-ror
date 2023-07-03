module Command
  attr_reader :result

  module Sender
    def call(*args, **kwargs)
      new(*args, **kwargs).call
    end
  end

  NotImplementedError = Class.new(StandardError)

  def self.prepended(base)
    base.extend Sender
  end

  def call
    raise NotImplementedError unless defined?(super)

    @result = super
    self
  end
end
