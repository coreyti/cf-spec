module CF::Spec
  module Transports
    class Base
      attr_reader :ui, :env

      def initialize(ui = UI.new, env = {})
        @ui  = ui
        @env = env
      end

      def config(uri = nil)
        unless uri.nil?
          @config = {
            host: uri.hostname,
            user: uri.user,
            pass: uri.password,
            path: uri.path,
            frag: uri.fragment
          }
        end

        @config || {}
      end

      def run(script, &block)
        execute!(bash(script), &block)
      end

      protected

      def executable(command)
        raise NotImplementedError
      end

      def execute!(script, &block)
        raise NotImplementedError
      end

      private

      def clean(string)
        return if string.nil?

        indent = (string.scan(/^[ \t]*(?=\S)/).min || '').size
        string.gsub(/^[ \t]{#{indent}}/, '').strip
      end

      def bash(script)
        command = clean(script).gsub(/"/, '\"').gsub(/\$/, "\\$")
        %Q{bash -c "#{executable(command)}"}
      end
    end
  end
end
