module Ribosome
  class Ribosome
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

    def render_options options, force_equals: false, force_quotes: false, quotes: '"'
      separator = force_equals ? '=' : ' '

      options.map do |key, value|
        case value
        when nil, true
          "--#{key}"
        when false
          "--no-#{key}"
        else
          if force_quotes
            "--#{key}#{separator}#{quotes}#{value}#{quotes}"
          else
            "--#{key}#{separator}#{value}"
          end
        end
      end.join(' ')
    end

    def run *args
      command_string = args.map do |item|
        if item.is_a? Hash
          render_options item
        else
          item
        end
      end.join(' ')

      if ::Ribosome.sandbox?
        puts "Running: #{command_string}"
      else
        `#{command_string}`
      end
    end

    def define_command command_name, &block
      unless block_given?
        block = proc do |*args|
          run command_name, *args
        end
      end

      define_singleton_method command_name, &block
    end

    def method_missing(name, *args)
      define_command name

      send(name, *args)
    end

    def respond_to_missing?(*)
      true
    end

    def synthesize
      instance_eval m_rna, gene
    end
  end
end
