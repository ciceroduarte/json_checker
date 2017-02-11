require 'json_checker/checkable_file'

module JsonChecker
	class JSONToCheck < CheckableFile   
	   attr_reader :keys, :remotes, :compareTo
	 
	   def initialize(representation)
	       super(representation)
	       @keys = representation['keys']
	       @remotes = representation['remotes']
	       @compareTo = representation['compare-to']
	  end
	end
end