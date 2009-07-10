module RCSS
  class Style < Builder
    ASSIGNMENT_METHOD = /.*=$/
    attr_reader :styles
    
    def initialize(context)
      @context = context
      @properties = {}
      @styles = []
    end
    
    def to_s
      output = ""
      output += "#{@context} {\n#{@properties.keys.sort.inject("") {|output, key| output += "#{key}: #{@properties[key]};\n"}}}\n" if @properties.size > 0
      @styles.inject(output) {|output, style| output += "#{output.size > 0 ? "\n" : ""}#{style.to_s}"}
    end
    
    def method_missing(symbol, *args)
      symbol = symbol.to_s.gsub(/_/, "-")
      if symbol =~ ASSIGNMENT_METHOD
        @properties[symbol[0, symbol.size - 1]] = args[0]
      end
    end
  end
end