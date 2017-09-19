module CF::Spec::Spec
  module Resources
    class File < Base
      def initialize(*args)
        @args = args
      end

      def to_s
        @args[0]
      end

      def exist?
        runner.context.file(*@args).exist?
      end
    end
  end
end
