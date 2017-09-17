module CF::Spec
  module Resources
    class << self
      def each(*args, &block)
        store.enum_for(:each, *args).each(&block)
      end

      private

      def store
        @store ||= begin
          self.constants.inject({}) do |memo, const|
            memo[const.to_s.downcase] = self.const_get(const) ; memo
          end
        end
      end
    end

    class Base
      def initialize(backend, *args)
        @backend = backend
      end
    end
  end
end

Dir[File.expand_path('../resources/*.rb', __FILE__)].each { |f| require(f) }
