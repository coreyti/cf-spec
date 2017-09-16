require 'thor'
require 'cf/spec/repl'

module CF::Spec
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
      config = Configuration.new(options.dup)
      CF::Spec::REPL.new(config: config).start
    end
  end
end
