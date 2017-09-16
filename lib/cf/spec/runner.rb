require 'uri'

module CF::Spec
  class Runner
    attr_reader :ui, :env

    def initialize(ui = UI.new, env = {})
      @ui  = ui
      @env = env
    end

    def run(script, &block)
      @transport.run(script, &block)
    end

    def target(uri)
      @transport = begin
        parsed = URI.parse(uri)
        result = Transports.find(parsed.scheme).new
        result.config(parsed)
        result
      end
    end
  end
end
