require_relative '../command'
require_relative '../ribosome'

module Ribosome
  module Commands
    class New < Command
      setup do
        usage 'new [OPTIONS] NAME'
        description 'Generates a new project'
        long_description nil

        execute do |name|
          # TODO
        end
      end
    end
  end
end
