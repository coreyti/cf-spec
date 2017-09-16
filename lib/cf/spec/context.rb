module CF::Spec
  class Context
    class << self
      def for(object)
        object.__binding__
      end
    end
  end
end
