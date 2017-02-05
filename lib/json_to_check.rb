class JSONToCheck
   
   attr_reader :name, :path, :remotePath, :keys, :remotes, :compareTo
 
   def initialize(representation)
       @name = representation['name']
       @path = representation['path']
       @remotePath = representation['remote-path']
       @keys = representation['keys']
       @remotes = representation['remotes']
       @compareTo = representation['compare-to']
  end
end