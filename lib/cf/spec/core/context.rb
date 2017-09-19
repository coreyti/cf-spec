module CF::Spec::Core
  class Context
    def initialize(config:)
      @config  = config
      @backend = CF::Spec::Core::Backends.load(@config.target)
    end

    protected

    def method_missing(method_name, *args, &block)
      resource = resources[method_name]
      resource ? resource.new(@backend, *args, &block) : super
    end

    def respond_to_missing?(method_name, include_private = false)
      !! resources[method_name]
    end

    private

    def resources
      @resources ||= {}.tap do |result|
        CF::Spec::Core::Resources.each do |name, impl|
          result[name.intern] = impl
        end
      end
    end
  end
end
