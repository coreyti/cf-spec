require 'thor'
require 'cf/spec/repl'

module CF
  module Spec
    class CLI < Thor
      class << self
        def shared
          option :target, aliases: :t, type: :string,
            desc: 'Target a backend. e.g., bosh://user:pass@director/deployment'
        end
      end

      desc 'repl', 'Start an interactive shell session'
      shared
      def repl
        config = options.dup
        runner = CF::Spec::Runner.new(config)
        CF::Spec::REPL.new(runner).start
      end
    end
  end
end
