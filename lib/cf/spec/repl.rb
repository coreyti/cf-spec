require 'pry'
require 'uri'

module CF::Spec
  class REPL
    def initialize(prompt: "cf-spec → ", config: Configuration.new) # TODO: share prompt with CLI
      @prompt = prompt
      @config = config.dup # or, does it want to be shared?
    end

    def start
      reset
      context.pry
    end

    private

    def reset
      Pry.hooks.clear_all

      Pry.config.prompt_name = @prompt
      Pry.prompt = [proc { "#{style("\e[0;32m")}#{Pry.config.prompt_name}#{style("\e[0m")}" }]
    end

    # ---

    # compose commands from:
    # - target   (backends)
    # - toolbelt (e.g., cfdot)
    # - profiles (or kits, bundles, ...)
    def context
      @context ||= Context.build(@config)
    end

    # ---

    def style(code)
      "\001#{code}\002"
    end
  end
end
