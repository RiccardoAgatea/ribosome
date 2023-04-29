require 'pathname'
require 'thor'
require_relative 'ribosome/version'

module Ribosome
  class Error < StandardError; end
end

require_relative 'ribosome/main'
