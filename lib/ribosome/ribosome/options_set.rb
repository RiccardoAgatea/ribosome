require 'active_support/core_ext/string/inflections'
require_relative 'option'
require_relative 'flag'

module Ribosome
  class Ribosome
    class OptionsSet
      attr_reader :options_instance_klass

      def initialize
        @options_instance_klass = Class.new do
          attr_reader :option_instances

          def initialize
            @option_instances = []
          end
        end
      end

      [:option, :flag].each do |kind|
        klass = const_get kind.camelize

        define_method kind do |name, *args, **kwargs, &block|
          new_option = klass.new(name, *args, **kwargs, &block)

          options_instance_klass.define_method name do |value=NOT_PROVIDED|
            option_instances << if value.equal? NOT_PROVIDED
                                  new_option.render
                                else
                                  new_option.render value
                                end
          end
        end
      end

      def render &block
        options_instance_klass
          .new
          .instance_exec(&block)
          .option_instances
          .join(' ')
      end
    end
  end
end
