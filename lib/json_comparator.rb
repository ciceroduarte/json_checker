require 'json-diff'
require './lib/checkable_file.rb'
require './lib/json_fetcher.rb'

class JSONComparator
  
  def self.compare(fileToCheck, compareTo)
        
    compareTo.each do |compare|
      
      checkableFile = CheckableFile.new(compare)
      fileContent = checkableFile.get_content()
      
      puts "##########################"
      puts " COMPARING #{fileToCheck.name} WITH #{checkableFile.name}"
      puts "##########################"
      
      jsonComparator = JSONComparator.new()
      jsonComparator.compare_json(fileToCheck.get_content(), fileContent)
    end
  end
  
  def compare_json(jsonToCheck, jsonToCompare)
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