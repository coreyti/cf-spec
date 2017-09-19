require 'highline'

module CF::Spec::Core
  class UI
    def initialize(input = $stdin, out = $stdout, err = $stderr)
      @out    = HighLine.new(input, out, nil, nil, 2, 0)
      @err    = HighLine.new(input, err, nil, nil, 2, 0)
      @output = @out
    end

    def err
      if block_given?
        current = @output
        @output = @err
        result  = yield
        @output = current
        result
      else
        @err
      end
    end

    def out
      if block_given?
        current = @output
        @output = @out
        result  = yield
        @output = current
        result
      else
        @out
      end
    end

    def indent(*args, &block)
      increase = args.shift || 1
      @out.indent_level += increase
      @err.indent_level += increase
      @output.indent(0, *args, &block)
      @out.indent_level -= increase
      @err.indent_level -= increase
    end

    def indent_level=(level)
      @out.indent_level = level
      @err.indent_level = level
    end

    protected

    def method_missing(method_name, *args, &block)
      if @output.respond_to?(method_name)
        @output.send(method_name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      @output.respond_to?(method_name) || super
    end
  end
end
