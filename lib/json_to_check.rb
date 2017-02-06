require './lib/checkable_file.rb'

class JSONToCheck < CheckableFile
   
   attr_reader :keys, :remotes, :compareTo
 
   def initialize(representation)
       super(representation)
       @keys = representation['keys']
       @remotes = representation['remotes']
       @compareTo = representation['compare-to']
  end
end