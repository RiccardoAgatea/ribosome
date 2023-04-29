require_relative '../command'

module Ribosome
  module Commands
    class Config < Command
      setup do
        usage 'config [OPTIONS] [NAME [VALUE]]'
        description 'Configures mutations'
        long_description nil

        option :global, type: :boolean
        option :local, type: :boolean

        execute do |name=NOT_PROVIDED, value=NOT_PROVIDED|
          if options.values_at(:global, :local).count(&:itself) > 1
            raise Thor::Error, 'You can access only one mutation file at a time, either global or local.'
          end

          # TODO
        end
      end
    end
  end
end
