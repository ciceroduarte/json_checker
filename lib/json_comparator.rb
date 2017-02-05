require 'json-diff'
require './lib/json_to_compare.rb'
require './lib/json_fetcher.rb'

class JSONComparator
  
  def self.compare(jsonToCheck, compareTo)
    
    compareTo.each do |compare|
      jsonToCompare = JSONToCompare.new(compare)
      
      jsonContent = ""
      
      if !jsonToCompare.path.nil?
        jsonContent = JSONFetcher.json_from_path(jsonToCompare.path)
      elsif !jsonToCompare.remotePath.nil?
        jsonContent = JSONFetcher.json_from_url(jsonToCompare.remotePath)
      else
        puts "[ERROR] path or remote-path not found"
        return
      end  
      
      jsonComparator = JSONComparator.new()
      jsonComparator.compareJSON(jsonToCheck, jsonContent)
      
    end
    
  end
  
  def compareJSON(jsonToCheck, jsonToCompare)
    jsonChecker = JSONValidator.new()
    diff = JsonDiff.diff(jsonToCheck, jsonToCompare)

    output = ""
    
    diff.each_with_index do |jsonDiff, index|
      op = jsonDiff["op"]
      puts op
  
      path = jsonDiff["path"]
      value = jsonChecker.value_for_key_with_split_character(path, jsonToCheck, "/")
  
      if op === "replace"
        puts "New value: #{value}"
        puts "Old value: #{jsonDiff["value"]}"
      else
        puts "Value: #{value}"
      end
      puts "For key: #{path}"

      puts output
    end
    
    return output
  end
  
  
end