require 'rcss/initializer'
require 'rcss/builder'
require 'rcss/style'

module RCSS
  def self.include_css(css_names)
    css_names.map do |name|
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"/stylesheets/#{name}.css\" />"
    end.join("\n") + "\n"
  end
end