require 'pathname'
require 'thor'
require_relative 'ribosome/version'

module Ribosome
  class Error < StandardError; end

  NOT_PROVIDED = ::Object.new
  private_constant :NOT_PROVIDED
end

require_relative 'ribosome/main'
