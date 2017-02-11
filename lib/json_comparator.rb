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
  
  def compare_json(json, jsonToCompare)    
    temp_json = tempfile_from_json(json)
    temp_jsonToCompare = tempfile_from_json(jsonToCompare)

    diff = Diffy::Diff.new(temp_json.path, temp_jsonToCompare.path, :source => 'files', :context => 3)
    diff.to_s.each_line do |line|
      puts "#{line}"
    end

    temp_jsonToCompare.delete
    temp_json.delete
  end

  def tempfile_from_json(json)
    tempfile = Tempfile.new("temp_json") 
    tempfile.write(JSON.pretty_generate(json) + "\n")
    tempfile.close
    return tempfile
  end

end
