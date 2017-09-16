module CF::Spec
  module Backends
    class Default < Base
      def example
        puts "this is an example command from the Default backend"
      end
    end
  end
end
