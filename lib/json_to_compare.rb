class JSONToCompare
   
   attr_reader :name, :path, :remotePath
 
   def initialize(representation)
       @name = representation['name']
       @path = representation['path']
       @remotePath = representation['remote-path']
   end
   
end