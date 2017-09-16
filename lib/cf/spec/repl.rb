require 'pry'
require 'uri'

module CF::Spec
  class REPL
    def initialize(runner)
      @runner = runner
    end

    def start
      prepare
      context.pry
    end

    private

    def context
      # parsed    = URI.parse('bosh://vbox/cf#diego-cell/0')
      parsed    = URI.parse('bosh://vbox/cf')
      transport = Transports.find(parsed.scheme).new
      transport.config(parsed)

      Context.for(transport)
    end

    def prepare
      namespace = 'bosh' # TODO

      Pry.hooks.clear_all
      this = self

      Pry.config.prompt_name = namespace
      Pry.prompt = [proc { "#{style("\e[0;32m")}#{Pry.config.prompt_name} → #{style("\e[0m")}" }]

      Pry.hooks.add_hook(:before_session, "#{namespace}_intro") do
        print_intro ; puts
      end

      Pry::Commands.block_command 'help', 'Describe available commands' do |resource|
        Commands::Help.new(namespace).execute #(resource)
      end
    end

    # ---

    def style(code)
      "\001#{code}\002"
    end

    def mark(text)
      "#{style("\033[1m")}#{text}#{style("\033[0m")}"
    end

    def print_intro
      puts
      puts "Welcome!"
      puts "To learn how to use this shell, type #{mark 'help'}"
    end

    module Commands
      class Base
        def initialize(namespace)
          @namespace = namespace
        end

        def style(code)
          "\001#{code}\002"
        end

        def justify(string)
          return if string.nil?

          number = (string.scan(/^[ \t]*(?=\S)/).min || '').size
          string.gsub(/^[ \t]{#{number}}/, '').lstrip
        end

        def mark(text)
          "#{style("\033[1m")}#{text}#{style("\033[0m")}"
        end
      end

      class Help < Base
        def execute(topic = nil)
          if topic.nil?
            puts justify %{
              Commands:

                #{mark 'run'} "<#{@namespace} command>"
                #{mark 'help'}
                #{mark 'exit'}
            }
          end
        end
      end
    end
  end
end
