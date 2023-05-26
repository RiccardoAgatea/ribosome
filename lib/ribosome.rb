require 'pathname'
require 'thor'
require_relative 'ribosome/version'

module Ribosome
  class Error < StandardError; end

  NOT_PROVIDED = ::Object.new
  private_constant :NOT_PROVIDED

  def self.root
    File.expand_path Pathname(__dir__) / '..'
  end

  DEFAULT_GENE_PATH = (Pathname(root) / 'vendor/assets/default_gene.rb').to_s

  # rubocop:disable Style/OptionalBooleanParameter
  def self.sandbox! new_value=true
    @sandbox = new_value
  end
  # rubocop:enable Style/OptionalBooleanParameter

  def self.sandbox?
    @sandbox
  end
end

require_relative 'ribosome/main'
