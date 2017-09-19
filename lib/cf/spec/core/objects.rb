module CF::Spec::Core
  # TODO: Courier ?
  module Objects
    class << self
      def define(backend, base, &block)
        cls = Class.new(self.const_get(base, false)) do
          define_method :evaluate do |string, &block|
            backend.send(:command, string, &block)
          end
          private :evaluate
        end

        cls.class_exec(&block) if block_given?
        cls
      end
    end
  end
end

Dir[File.expand_path('../objects/*.rb', __FILE__)].each { |f| require(f) }
