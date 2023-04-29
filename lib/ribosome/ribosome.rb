require_relative 'ribosome/has_commands'

module Ribosome
  class Ribosome
    include HasCommands

    attr_reader :gene
    attr_reader :m_rna
    attr_reader :project_name
    attr_reader :params

    def initialize gene, project_name:, **params
      @gene = gene
      @m_rna = File.read self.gene
      @project_name = project_name

      params.each do |key, value|
        define_singleton_method key do
          value
        end
      end

      params[:project_name] = project_name

      @params = params.freeze
    end

    alias executable command

    def synthesize
      instance_eval m_rna, gene
    end
  end
end
