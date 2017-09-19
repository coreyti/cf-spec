module CF::Spec::Core
  module Backends
    class BOSH < Base
      def file(path)
        _File.new(path)
      end

      private

      def command(string, &block)
        transport.run("ssh -c '#{string}'") do |line|
          if block_given?
            stream = line.match(/: stderr \|/) ? :stderr : :stdout
            args   = [sanitize(line)]
            args  << stream if block.arity == 2
            block.call(*(args.compact))
          end
        end
      end

      def sanitize(line)
        line.sub(/^.*std(err|out) \| /, '')
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
