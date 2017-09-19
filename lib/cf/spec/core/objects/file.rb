module CF::Spec::Core
  module Objects
    class File
      def initialize(path)
        @path = path
      end

      def read
        content = StringIO.new

        evaluate("cat #{@path} || echo -n") do |line, stream|
          content.puts line if stream == :stdout
        end

        content.string.strip # NOTE: stripping because BOSH prints extra lines
      end

      def exist?
        evaluate("test -e #{@path}").success?
      end
    end
  end
end
