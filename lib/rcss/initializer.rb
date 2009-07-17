module RCSS
  class Initializer
    require 'ostruct'
    
    attr_reader :config
    
    RUBY_SOURCE_NAME_MATCHER = /(.*)\.rb/
    
    def initialize
      @config = OpenStruct.new
      @config.compress = false
      @config.namespace = "Css"
      @config.css_root = "#{RAILS_ROOT}/app/css"
      @config.output_path = "#{RAILS_ROOT}/public/stylesheets"
    end
    
    def self.run(&block)
      initializer = RCSS::Initializer.new
      yield initializer.config if block_given?
      initializer.build_css
      initializer
    end
    
    def build_css
      if @config.compressed
        FileUtils.touch(File.join(@config.output_path, "all.css"))
      end
      process_path
    end
    
    def method_missing(symbol, *args)
      @config.send(symbol, *args)
    end
    
    protected
      def process_path(sub_path = "")
        current_path = File.join(@config.css_root, sub_path)
        Dir.entries(current_path).each do |entry|
          unless File.directory?(File.join(current_path, entry))
            if entry =~ RUBY_SOURCE_NAME_MATCHER
              class_name = entry.gsub(/\.rb/, "")
              @config.compress ? create_compressed(sub_path, class_name) : create_entry(sub_path, class_name)
            end
          else
            unless [".", ".."].include?(entry)
              FileUtils.mkdir(File.join(@config.output_path, sub_path, entry)) unless @config.compress
              process_path(File.join(sub_path, entry))
            end
          end
        end
      end
      
      def create_entry(directory, class_name)
        file = File.new(File.join(@config.output_path, directory, "#{class_name}.css"), "w")
        file.write(get_module_constant(File.join(directory, class_name)).new.render.to_s)
        file.close        
      end
      
      def create_compressed(directory, class_name)
        file = File.open(File.join(@config.output_path, "all.css"), "w+")
        file.write(get_module_constant(File.join(directory, class_name)).new.render.to_s)
        file.close
      end
      
      def get_module_constant(path)
        opener = @config.namespace ? Module.const_get(@config.namespace) : Module
        path.split("/").collect {|section| section.capitalize}.select{|token| token && token.length > 0}.inject(opener) do |current_module, name|
          current_module.const_get(name.to_sym)
        end
      end
  end
end