require 'open3'

module CF::Spec::Core
  module Transports
    class Base
      attr_reader :env

      def initialize(uri:, env: {})
        @uri = uri
        @env = env.dup
      end

      def run(script, &block)
        Open3.popen2e(env, "#{bash(script)}") do |stdin, stdoe, thread|
          while line = stdoe.gets
            block.call(line) if block_given?
          end

          thread.value
        end
      end

      protected

      def command(params = '')
        raise NotImplementedError
      end

      private

      def bash(script)
        params = clean(script).gsub(/"/, '\"').gsub(/\$/, "\\$")
        %Q{bash -c "#{command(params)}"}
      end

      def clean(string)
        return if string.nil?

        indent = (string.scan(/^[ \t]*(?=\S)/).min || '').size
        string.gsub(/^[ \t]{#{indent}}/, '').strip
      end

      def config
        @config ||= Configuration.new({
          host: @uri.hostname,
          user: @uri.user,
          pass: @uri.password,
          path: @uri.path,
          frag: @uri.fragment
        })
      end
    end
  end
end

Dir[File.expand_path('../transports/*.rb', __FILE__)].each { |f| require(f) }
