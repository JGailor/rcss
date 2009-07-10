module RCSS
  class Builder    
    def initialize
      @context = ""
      @styles = []
    end
    
    def style(selector, &block)
      style = RCSS::Style.new("#{@context} #{selector}".strip)
      yield style
      @styles << style
    end
    
    def to_s
      @styles.inject("") {|output, style| output += style.to_s}
    end
  end
end