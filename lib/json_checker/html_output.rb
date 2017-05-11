module JsonChecker
  class HTMLOutput
  
    def self.add_validation_item(title, values)

      if title.nil? || values.nil? || !values.is_a?(Array)
        return
      end

      item = "<h2>#{title}</h2>"
      item << "<div class=\"validation\" style=\"overflow-x:auto;\">
      <table><tr><th>Status</th><th>Key</th><th>Expected</th><th>Value</th></tr>"

      values.each do |value|
        item << value
      end

      item << "</table></div>"
      HTMLOutput.add_item(item)
    end

    def self.add_comparation_item(title, json)

      if title.nil? || json.nil?
        return
      end

      item = "<h2>#{title}</h2>" + "<div class=\"diff\">" + json + "</div>"
      HTMLOutput.add_item(item)
    end

    def self.generate_output()
      htmlOutput = HTMLOutput.new()
      output = "<html>" + htmlOutput.add_style() + "<body>"
      @reportItems.each do |item| 
        output << item
      end
      output << "</body></html>"

      htmlOutput.save_to_file(output)
    end

    def self.add_item(item)
      if @reportItems.nil?
        @reportItems = Array.new()
      end
      @reportItems << item
    end 

    def add_style()
      return "
        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
        <style>  
        .addition { background: #eaffea; }
        .remotion { background: #ffecec; }
        .diff { outline: 1px solid #eff0d6; margin: 5px; padding-top: 5px; padding-bottom: 5px; }
        .validation { margin: 5px; }
        body { font-family: monospace; }
        table { border-collapse: collapse; width: 100%; }
        td { border: 1px solid #eff0d6; }
        th { background-color: #4CAF50; color: white; border: 1px solid #4CAF50; }
        th, td { padding: 5px; text-align: left; }
        tr:hover { background-color: #f5f5f5 }
        p { margin-top: 0em; margin-bottom: 0em; white-space: pre; padding : 3; color: #3e3333 }
      </style>"
    end

    def save_to_file(report)
      if report.nil?
        puts "[ERROR] Invalid report"
      else
        File.write("output.html", report)
      end
    end

  end
end