require "yaml"

module Pointillist
  class << self
    attr_accessor :syntax_path
    attr_accessor :syntaxes
  end

  # Error class
  class PointillistError < IOError
  end

  self.syntax_path = File.join(File.dirname(__FILE__), '..', 'languages')
  self.syntaxes    = YAML.load_file(File.join(@syntax_path, '_languages.yml'))

  # Public: Highlight code.
  #
  # Takes a first-position argument of the code to be highlighted, and a
  # second-position hash of various arguments specifiying highlighting properties.
  def self.highlight(code, name)
    # If the caller didn't give us any code, we have nothing to do
    return code if code.nil? || code.empty?

    lexer = Lexer.find_by_name(name)
    raise PointillistError, "No #{name} lexer!" if lexer.nil?
    lexer.highlight(code)
  end

  require "pointillist/lexer"
  require "pointillist/version"
end
