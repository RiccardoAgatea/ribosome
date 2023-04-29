require 'active_support/core_ext/string/inflections'

module Ribosome
  class Command
    {
      usage:                    nil,
      description:              nil,
      description_options:      -> { {} },
      long_description:         nil,
      long_description_options: -> { {} },
      command_name:             -> { self.class.name.demodulize.underscore },
      command:                  nil,
      options:                  -> { [] }
    }.each do |attribute_name, default_value|
      instance_variable_name = :"@#{attribute_name}"
      define_method attribute_name do |new_value=NOT_PROVIDED|
        if new_value.equal? NOT_PROVIDED
          if instance_variable_defined? instance_variable_name
            instance_variable_get instance_variable_name
          else
            resolved_default_value = if default_value.is_a? Proc
                                       instance_exec(&default_value)
                                     else
                                       default_value
                                     end

            instance_variable_set instance_variable_name, resolved_default_value
          end
        else
          instance_variable_set instance_variable_name, new_value
        end
      end
    end

    def option(*args, **kwargs, &block)
      options << [args, kwargs, block]
    end

    def execute &block
      command block
    end

    def self.setup &block
      if block.nil?
        @setup
      else
        @setup = block
      end
    end

    def initialize
      instance_exec(&self.class.setup)
    end
  end
end
