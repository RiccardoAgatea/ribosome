require_relative '../command'
require_relative '../ribosome'

module Ribosome
  module Commands
    class New < Command
      setup do
        usage 'new [OPTIONS] NAME'
        description 'Generates a new project'
        long_description nil

        option :gene, default: DEFAULT_GENE_PATH
        option :sandbox, default: false

        execute do |name|
          ::Ribosome.sandbox! options[:sandbox]
          params = options.except :gene
          Ribosome.new(options[:gene], project_name: name, **params).synthesize
        end
      end
    end
  end
end
