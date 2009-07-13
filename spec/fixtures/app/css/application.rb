class Application < RCSS::Builder
  def content
    style("body") do |body_style|
      body_style.text_align = "left"
    end
  end
end