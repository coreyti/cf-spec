module CF::Spec
  module Resources
    class File < Base
      def initialize(backend, path)
        super
        @path = path
        @file = backend.file(path)
      end

      def exist?
        @file.exist?
      end

      def read
        @file.read
      end

      # ---

      def to_s
        inspect
      end

      def inspect
        "#<CF::Spec::Resources::File:0x#{self.__id__.to_s(16)} @backend=#{@backend.type} @path=#{@path}>"
      end
    end
  end
end
