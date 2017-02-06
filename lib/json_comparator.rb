require 'json-diff'
require './lib/checkable_file.rb'
require './lib/json_fetcher.rb'

class JSONComparator
  
  def self.compare(jsonToCheck, compareTo)
    
    puts "#############"
    puts "# COMPARING #"
    puts "#############"
    
    compareTo.each do |compare|
      checkableFile = CheckableFile.new(compare)
      
      jsonContent = ""
      
      if checkableFile.path.nil?
        jsonContent = JSONFetcher.json_from_path(checkableFile.path)
      elsif checkableFile.remotePath.nil?
        jsonContent = JSONFetcher.json_from_url(checkableFile.remotePath)
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
    diff = JsonDiff.diff(jsonToCompare, jsonToCheck)

    diff.each_with_index do |jsonDiff, index|
      op = jsonDiff["op"]
      path = jsonDiff["path"]
      value = jsonChecker.value_for_key_with_split_character(path, jsonToCheck, "/")
      oldValue = jsonChecker.value_for_key_with_split_character(path, jsonToCompare, "/")
  
      if op === "replace"
        puts "[REPLACED] #{oldValue} with #{value} for path: #{path}"
      elsif op == "remove"
        puts "[REMOVED] #{oldValue} for path: #{path}"
      else
        puts "[ADDED] #{value} for path: #{path}"
      end
    end
  end
end