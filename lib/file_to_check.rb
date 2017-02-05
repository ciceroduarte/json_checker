class FileToCheck
   
   attr_reader :name, :path, :remotePath, :keys, :remotes
 
   def initialize(representation)
       @name = representation['name']
       @path = representation['path']
       @remotePath = representation['remote-path']
       @keys = representation['keys']
       @remotes = representation['remotes']
  end

   def self.isValidRepresentation(representation)
      return (representation.keys.include? 'name') && (representation.keys.include? 'path')
   end
end