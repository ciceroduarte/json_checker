class CheckableFile
   
   attr_reader :name, :path, :remotePath
 
   def initialize(representation)
       @name = representation['name']
       @path = representation['path']
       @remotePath = representation['remote-path']
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