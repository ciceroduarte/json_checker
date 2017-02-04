class Diff
    
 attr_reader :type, :path, :value
  
 def initialize(type, path, value)
  @type = type
  @path = path
  @value = value
 end
end