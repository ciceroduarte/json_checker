class Remote
   
   attr_accessor :content
   attr_reader :name, :url
 
   def initialize(representation)
       @name = representation['name']
       @url = representation['url']
   end

   def self.isValidRepresentation(representation)
      return (representation.keys.include? 'name') && (representation.keys.include? 'url')
   end
end