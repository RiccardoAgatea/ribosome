module Ribosome
  class Ribosome
    class Option
      attr_reader :name
      attr_reader :default
      attr_reader :options

      def initialize name, command_line_name=name, default: nil, equals: false, dashes: false
        @name = name
        @command_line_name = command_line_name
        @default = default
        @options = {
          equals: equals,
          dashes: dashes
        }
      end

      def command_line_name _value
        @command_line_name
      end

      def render value=default
        [
          ('--' if options[:dashes]),
          command_line_name(value),
          (options[:equals] ? '=' : ' '),
          value
        ].join('')
      end
    end
  end
end
