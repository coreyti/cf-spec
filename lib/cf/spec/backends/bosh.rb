module CF::Spec
  module Backends
    class BOSH < Base
      def file(path)
        _File.new(path)
      end

      private

      def command(string, &block)
        transport.run("ssh -c '#{string}'") do |line|
          block.call(line) if block_given?
        end
      end

      def transport
        @transport ||= Transports::BOSH.new(uri: @uri)
      end

      # ---

      def _File
        @_File ||= Objects.define(self, :File)
      end
    end
  end
end
