require 'active_support/core_ext/module/delegation'
require_relative 'has_commands'

module Ribosome
  class Ribosome
    class Command
      include HasCommands

      attr_reader :name
      attr_reader :options

      def initialize name, &block
        @name = name
        instance_exec(&block)
      end

      delegate :option, :flag, to: :options

      def render(*parameters, &block)
        [
          name,
          *parameters,
          options.render(&block)
        ].join(' ')
      end
    end
  end
end
