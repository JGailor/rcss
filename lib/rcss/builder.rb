module RCSS
  class Builder    
    def initialize
      @context = ""
      @styles = []
    end
    
    def render
      content
      to_s
    end
    
    def content
      # empty stub
    end
    
    def style(selector, &block)
      current_style = RCSS::Style.new("#{@context} #{selector}".strip)
      current_style.instance_eval(&block)
      @styles << current_style
    end
    
    def to_s
      @styles.inject("") {|output, style| output += style.to_s}
    end
  end
end