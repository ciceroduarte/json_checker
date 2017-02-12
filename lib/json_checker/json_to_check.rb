require 'json_checker/checkable_file'

module JsonChecker
  class JSONToCheck < CheckableFile   
	  attr_reader :keys, :compareTo
	 
	  def initialize(representation)
		super(representation)
		@keys = representation['keys']
		@compareTo = representation['compare-to']
	  end
  end
end