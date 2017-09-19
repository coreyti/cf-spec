require 'thor'

module CF::Spec
  class CLI < Thor
    class << self
      def shared
        option :target, aliases: :t, type: :string,
          desc: 'Target a backend. e.g., bosh://user:pass@director/deployment'
      end
    end

    desc 'repl', 'Start an interactive shell'
    shared
    def repl
      CF::Spec::CLI::Commands::REPL.new(runner: runner).start
    end

    # desc 'spec <path>', 'Execute behavior specs'
    # shared
    # def spec(path)
    #   runner.run
    # end

    private

    def runner
      @runner ||= begin
        config = CF::Spec::Core::Configuration.new(options.dup)
        CF::Spec::Core::Runner.new(config: config)
      end
    end
  end
end

require 'cf/spec/cli/commands'
