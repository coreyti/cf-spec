require 'uri'

module CF::Spec
  class Runner
    def initialize(config: Configuration.new)
      @config  = config.dup
    end

    def context
      @context ||= Context.build(config: @config)
    end
  end
end
