module CF::Spec
  module Objects
    class << self
      def define(backend, base, &block)
        cls = Class.new(self.const_get(base, false)) do
          define_method :evaluate do |string|
            backend.send(:command, string)
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
