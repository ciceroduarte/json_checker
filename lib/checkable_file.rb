class CheckableFile
   
   attr_reader :name, :path, :remotePath
 
   def initialize(representation)
       @name = representation['name']
       @path = representation['path']
       @remotePath = representation['remote-path']
  end
  
  def get_content()

    if !@content.nil?
      return @content
    end    

    if !@path.nil?
      @content = JSONFetcher.json_from_path(@path)
    elsif !@remotePath.nil?
      @content = JSONFetcher.json_from_url(@remotePath)
    else
      puts "[ERROR] path or remote-path not found"
      return nil
    end  
    return @content
  end
  
end