module Ribosome
  class Ribosome
    class Command
      # Forward declaration
    end

    module HasCommands
      def command name, &block
        new_command = Command.new name, &block

        # TODO: no likey at all. The problem is that I have no way to know if the command is the last of a chain or if
        #   it's going to be chained further, eg I can't tell the difference between `rails` in
        #
        #   ```
        #   rails {version}
        #   ```
        #
        #   and `rails` in
        #
        #   ```
        #   rails.new(project_name) {assets_pipeline false}
        #   ```
        #
        #   but in the first case I have to render the options and then execute the string I get, and in the second case
        #   I have to go on rendering the subcommand. I'm not sure there even is a solution...
        define_singleton_method name do |*parameters, &options_block|
          new_command.render(*parameters, &options_block)
        end
      end
    end
  end
end

require_relative 'command'
