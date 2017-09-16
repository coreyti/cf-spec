module CF::Spec
  class Context
    class << self
      # NOTE: this is a bit odd if the thing is a singleton
      def build(config)
        @config = config
        instance.__binding__
      end

      private

      def instance
        @instance ||= self.new(@config)
      end
    end

    def initialize(config)
      @resources = [].tap do |result|
        result << CF::Spec::Backends.load(config.target)
      end
    end

    protected

    def method_missing(method_name, *args, &block)
      handler = @resources.first do |resource|
        resource.respond_to?(method_name)
      end

      handler ? handler.send(method_name, *args, &block) : super
    end

    def respond_to_missing?(method_name, include_private = false)
      @resources.any? { |resource| resource.respond_to?(method_name) } || super
    end
  end
end
