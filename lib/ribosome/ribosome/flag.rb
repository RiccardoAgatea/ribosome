require_relative 'option'

module Ribosome
  class Ribosome
    class Flag < Option
      alias command_line_name_true command_line_name
      attr_reader :command_line_name_false
      attr_reader :switched

      def initialize name, command_line_name_true=name, command_line_name_false=nil, switched: false, **kwargs
        super(name, command_line_name_true, **kwargs)

        command_line_name_false = "no-#{command_line_name_true}" if command_line_name_false.nil?

        @command_line_name_false = command_line_name_false
        @switched = (switched ? true : false)
      end

      # v | s | res
      # t | t | f
      # t | f | t
      # f | t | t
      # f | f | f
      #
      # => It's a XOR
      def command_line_name value
        value = (value ? true : false)
        if value ^ switched
          command_line_name_true
        else
          command_line_name_false
        end
      end
    end
  end
end
