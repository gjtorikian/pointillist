require 'textpow'

module Pointillist
  class Lexer < Struct.new(:name, :path)
    @lexers          = []
    @index           = {}
    @name_index      = {}

    # Internal: Create a new Lexer object
    #
    # name - The name of the lexer
    # hash - A hash of attributes
    #
    # Returns a Lexer object
    def self.create(name, hash)
      grammar = YAML.load_file(File.join(Pointillist.syntax_path, hash["path"]))
      lexer = new(name, grammar)

      @lexers << lexer

      @index[lexer.name.downcase] = @name_index[lexer.name] = lexer

      lexer
    end

    # Public: Get all Lexers
    #
    # Returns an Array of Lexers
    def self.all
      @lexers
    end

    # Public: Look up Lexer by name.
    #
    # name - A String name
    #
    #   Lexer.find('Ruby')
    #   => #<Lexer name="Ruby">
    #
    # Returns the Lexer or nil if none was found.
    def self.find_by_name(name)
      @index[name.to_s.downcase]
    end

    # Public: Alias for find.
    def self.[](name)
      find_by_name(name)
    end

    # Public: Highlight syntax of text
    #
    # text    - String of code to be highlighted
    # options - Hash of options (defaults to {})
    #
    # Returns html String
    def highlight(text, options = {})
      require 'pp'
      x = Pointillist::Processor.load do |processor|
        syntax_node = Textpow::SyntaxNode.load(File.join(Pointillist.syntax_path, "ruby.json"))
        syntax_node.parse(text, processor)
      end.string
      pp "poop", x
    end

    alias_method :==, :equal?
    alias_method :eql?, :equal?
  end

  Pointillist.syntaxes.each { |k, v| Lexer.create(k, v) }
end
