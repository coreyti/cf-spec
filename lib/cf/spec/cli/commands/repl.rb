require 'pry'
require 'uri'

module CF::Spec::CLI::Commands
  class REPL
    # TODO: share prompt (prefix) with CLI
    def initialize(prompt: "cf-spec → ", runner:)
      @prompt = prompt
      @runner = runner
    end

    def start
      reset
      @runner.context.pry
    end

    private

    def reset
      Pry.hooks.clear_all

      Pry.config.prompt_name = @prompt
      Pry.prompt = [proc { "#{style("\e[0;32m")}#{Pry.config.prompt_name}#{style("\e[0m")}" }]
    end

    # ---

    def style(code)
      "\001#{code}\002"
    end
  end
end
