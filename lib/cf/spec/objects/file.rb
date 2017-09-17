module CF::Spec
  module Objects
    class File
      def initialize(path)
        @path = path
      end

      def exist?
        evaluate("test -e #{@path}").success?
      end
    end
  end
end
