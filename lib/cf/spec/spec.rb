require 'rspec'
require 'cf/spec/version'
require 'cf/spec/core'

module CF::Spec::Spec
  class << self
    # def configuration
    #   CF::Spec::Spec::Configuration
    # end

    # def example=(value)
    #   @example = value
    # end
    #
    # def example
    #   @example
    # end

    def runner=(value)
      @runner = value
    end

    def runner
      @runner
    end
  end

  # module Configuration
  #   class << self
  #     OPTIONS = [
  #       :target
  #     ]
  #
  #     def defaults
  #       OPTIONS.inject({}) { |memo, key| memo.merge!(key: send(key)) }
  #     end
  #   end
  # end

  # serverspec/helper/type
  module Resources
    class Base
      def runner
        CF::Spec::Spec.runner
      end
    end

    types = ['file']

    types.each do |type|
      require "cf/spec/spec/resources/#{type}"

      define_method type do |*args| # &block ?
        name = type.split('_').map(&:capitalize).join # camelcase
        CF::Spec::Spec::Resources.const_get(name).new(*args)
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do
    config = CF::Spec::Core::Configuration.new(target: 'bosh://vbox/cf#diego-cell/0')
    CF::Spec::Spec.runner = CF::Spec::Core::Runner.new(config: config)
    # CF::Spec::Spec.example = RSpec.current_example
  end
end

instance_exec do
  extend CF::Spec::Spec::Resources
end
