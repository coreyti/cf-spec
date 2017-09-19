module CF::Spec::Core
  module Transports
    class BOSH < Base
      def command(params)
        ['bosh', globals, rebuild(params)]
          .delete_if { |part| part == '' }
          .join(' ')
      end

      private

      def deployment
        @deployment ||= config.path.sub(/^\//, '')
      end

      # ---

      def rebuild(params)
        params.split(' ').insert(1, target)
          .delete_if { |part| part == '' }
          .compact.join(' ')
      end

      def globals
        [].tap do |result|
          result << "-e #{address[:environment]}" if address[:environment]
          result << "-d #{address[:deployment]}"  if address[:deployment]
        end.join(' ')
      end

      def target
        [address[:group], address[:index]].compact.join('/')
      end

      # ---

      def address
        @target ||= {}.tap do |result|
          path = (config.path || '').split('/').delete_if { |part| part == '' }
          frag = (config.frag || '').split('/').delete_if { |part| part == '' }

          result[:environment] = config.host if config.host
          result[:deployment]  = path[0]
          result[:group]       = frag[0]
          result[:index]       = frag[1]
        end
      end
    end
  end
end
