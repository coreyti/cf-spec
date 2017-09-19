require 'uri'

module CF::Spec::Core
  module Backends
    class << self
      def find(name)
        store[name] || CF::Spec::Core::Backends::Default
      end

      def load(uri)
        parsed = URI.parse(uri || 'default://')
        find(parsed.scheme).new(uri: parsed)
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
      attr_reader :ui

      def initialize(uri:, ui: UI.new)
        @uri = uri
        @ui  = ui
      end

      def type
        @name ||= self.class.name.split('::').last.downcase.intern
      end
    end
  end
end

Dir[File.expand_path('../backends/*.rb', __FILE__)].each { |f| require(f) }
