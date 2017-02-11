require 'diffy'
require 'tempfile'
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
    temp_jsonToCompare = Tempfile.new("temp_jsonToCompare") 
    temp_jsonToCheck = Tempfile.new("temp_jsonToCheck")

    temp_jsonToCheck.write(jsonToCheck.to_json)
    temp_jsonToCheck.close
    
    temp_jsonToCompare.write(jsonToCompare.to_json)
    temp_jsonToCompare.close

    diff = Diffy::Diff.new(temp_jsonToCheck.path, temp_jsonToCompare.path, :source => 'files', :context => 3)
    diff.to_s.each_line do |line|
      puts "#{line}"
    end

    temp_jsonToCompare.delete
    temp_jsonToCheck.delete
  end

end
