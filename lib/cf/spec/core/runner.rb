module CF::Spec::Core
  class Runner
    def initialize(config: Configuration.new)
      @config = config.dup
    end

    def context
      @context ||= Context.new(config: @config)
    end
  end
end
