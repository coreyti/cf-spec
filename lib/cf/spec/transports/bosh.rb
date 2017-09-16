require 'open3'

module CF::Spec
  module Transports
    class BOSH < Base
      def initialize(*)
        super
      end

      def execute!(script, &block)
        Open3.popen2e(env, "#{script}") do |stdin, stdoe, thread|
          while line = stdoe.gets
            ui.say(line)
            block.call(line) if block_given?
          end

          thread.value
        end
      end
    end
  end
end
