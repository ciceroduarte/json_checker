
require "json_checker/json_fetcher"

module JsonChecker
  class CheckableFile
    attr_reader :name, :path, :remotePath
   
     def initialize(representation)
         @name = representation['name']
         @path = representation['path']
         @remotePath = representation['remote-path']
    end
    
    def self.is_valid_representation?(representation)
      json = JsonChecker::JSONFetcher.json_from_content(representation)
      unless json.nil?
          return (json.keys.include? 'name') && 
          (json.keys.include? 'path') || 
          (json.keys.include? 'remote-path')
      end
      return false
    end

    def get_content()
      if @path.nil? && @remotePath.nil?
        puts "[ERROR] path or remote-path not found"
        return nil
      end

      unless @content.nil?
        return @content
      end

      @content = @path.nil? ? JSONFetcher.json_from_url(@remotePath) : JSONFetcher.json_from_path(@path)

      return @content
    end 
  end
end