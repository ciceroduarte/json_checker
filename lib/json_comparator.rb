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
    puts diff
    html_report_from_diff(diff)
    temp_jsonToCompare.delete
    temp_json.delete
  end

  def tempfile_from_json(json)
    tempfile = Tempfile.new("temp_json") 
    tempfile.write(JSON.pretty_generate(json) + "\n")
    tempfile.close
    return tempfile
  end

  def html_report_from_diff(diff) 
    result = ""
    style = "<style>  
        .addition {
            background: #eaffea;
        }
        .remotion {
            background: #ffecec;
        }
        div {
            outline: 1px solid #eff0d6;
            margin: 5px;
            padding: 8px;
            background: #ffffff;
        }
        p {

            margin-top: 0em;
            margin-bottom: 0em;
            white-space: pre;
            font-family: monospace;
            padding : 3;
            color: #3e3333
        }
    </style>"

    diff.to_s.each_line do |line|
      result = result + add_line(line)
    end

    #puts "<html>" + style + "<div>" +  result + "</div>" + "</html>"
  end

  def add_line(line)
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