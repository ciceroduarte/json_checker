require 'diffy'
require 'tempfile'
require 'json_checker/checkable_file'
require 'json_checker/json_fetcher'

module JsonChecker
  class JSONComparator
    def self.compare(fileToCheck, compareTo)
      
      if fileToCheck.nil? || compareTo.nil? || !compareTo.is_a?(Array) || !fileToCheck.is_a?(JSONToCheck)
        return
      end

      compareTo.each do |compare|
        if CheckableFile.is_valid_representation?(compare)
          checkableFile = CheckableFile.new(compare)
          fileContent = checkableFile.get_content()

          jsonComparator = JSONComparator.new()
          jsonComparator.compare_json("Comparing #{fileToCheck.name} with #{checkableFile.name}", fileToCheck.get_content(), fileContent)
        end
      end
    end

    def compare_json(title, json, jsonToCompare)    
      temp_json = tempfile_from_json(json)
      temp_jsonToCompare = tempfile_from_json(jsonToCompare)

      unless temp_json.nil? && temp_jsonToCompare.nil?
        diff = Diffy::Diff.new(temp_json.path, temp_jsonToCompare.path, :source => 'files', :context => 3)
        puts diff
        html_report_from_diff(title, diff)

        temp_jsonToCompare.delete
        temp_json.delete
      end
    end

    def tempfile_from_json(json)
      json = JSONFetcher.json_from_content(json)
      unless json.nil?
        tempfile = Tempfile.new("temp_json")
        tempfile.write(JSON.pretty_generate(json) + "\n")
        tempfile.close
        return tempfile
      end
      puts "[ERROR] File content is not a valid JSON"
      return nil
    end

    def html_report_from_diff(title, diff)
      if diff.nil?
        return nil
      end

      result = ""
      diff.to_s.each_line do |line|
        result = result + add_line(line)
      end
      HTMLOutput.add_comparation_item(title, result)
    end

    def add_line(line)
      
      if line.nil?
        return ""
      end 

      line = line.gsub("\n","")
      formatter = "<p class=\"%{first}\">%{second}</p>"
      className = "null"

      if line.chars.first == "+"
        className = "addition"
      elsif line.chars.first == "-"
        className = "remotion"
      end
      return formatter % {first: className, second: line}
    end
  end
end
