require 'open3'

module CF::Spec
  module Transports
    class BOSH < Base
      def command(params)
        "bosh -e #{config.host} -d #{deployment} #{rebuild(params)}"
      end

      private

      def deployment
        @deployment ||= config.path.sub(/^\//, '')
      end

      # ---

      def rebuild(params)
        params.split(' ').insert(1, config.frag).compact.join(' ')
      end
    end
  end
end
