$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
$LOAD_PATH << File.join(File.dirname(__FILE__), "fixtures", "app")

require 'spec'
require 'rcss'
require 'css/global'
require 'css/application/layouts'
require 'css/users/admins'

RAILS_ROOT = File.join(File.dirname(__FILE__), "fixtures")
SAMPLE_CSS_OUTPUT_PATH = File.join(File.dirname(__FILE__), "fixtures", "public", "stylesheets")

Spec::Runner.configure do |config|
  config.before(:each) do
    FileUtils.mkdir_p(SAMPLE_CSS_OUTPUT_PATH) unless File.directory?(SAMPLE_CSS_OUTPUT_PATH)
  end
  
  config.after(:each) do
    Dir.entries(SAMPLE_CSS_OUTPUT_PATH).each do |entry|
      FileUtils.rm_rf(File.join(SAMPLE_CSS_OUTPUT_PATH, entry)) unless [".", ".."].include?(entry)
    end
  end
end