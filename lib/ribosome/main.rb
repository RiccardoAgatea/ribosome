Dir["#{__dir__}/commands/**/*.rb"].each do |filepath|
  require filepath
end

module Ribosome
  class Main < Thor
    def self.define_command command
      desc command.usage, command.description, **command.description_options
      long_desc command.long_description, **command.long_description_options
      command.options.each do |args, kwargs, block|
        option(*args, **kwargs, &block)
      end
      define_method command.command_name, &command.command
    end

    Commands.constants(false).each do |constant_name|
      command_klass = Commands.const_get constant_name
      define_command command_klass.new
    end

    def self.exit_on_failure?
      true
    end
  end
end
