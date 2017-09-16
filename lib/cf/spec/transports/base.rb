module CF::Spec
  module Transports
    class Base
      attr_reader :ui, :env

      def initialize(ui = UI.new, env = {}, &block)
        @ui  = ui
        @env = env
        instance_exec(&block) if block_given?
      end

      def run(script, &block)
        execute!(executable(script), &block)
      end

      protected

      def execute!(script, &block)
        raise NotImplementedError
      end

      private

      def clean(string)
        return if string.nil?

        indent = (string.scan(/^[ \t]*(?=\S)/).min || '').size
        string.gsub(/^[ \t]{#{indent}}/, '').strip
      end

      def executable(script)
        content = clean(script).gsub(/"/, '\"').gsub(/\$/, "\\$")
        %Q{bash -c "#{content}"}
      end
    end
  end
end
