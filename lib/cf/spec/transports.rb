module CF
  module Spec
    module Transports
      class << self
        def find(scheme)
          store[scheme]
        end

        private

        def store
          @list ||= begin
            self.constants.inject({}) do |memo, const|
              memo[const.to_s.downcase] = self.const_get(const) ; memo
            end
          end
        end
      end
    end
  end
end

require 'cf/spec/transports/base'
require 'cf/spec/transports/bosh'
