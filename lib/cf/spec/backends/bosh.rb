module CF::Spec
  module Backends
    class BOSH < Base
      def bosh(string, &block)
        transport.run(string) do |line|
          ui.say line
          block.call(line) if block_given?
        end
      end

      private

      def transport
        @transport ||= Transports::BOSH.new(uri: @uri)
      end
    end
  end
end
