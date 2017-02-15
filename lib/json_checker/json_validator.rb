require 'json'
require 'json_checker/json_to_check'
require 'json_checker/json_fetcher'
require 'json_checker/json_comparator'
require 'json_checker/html_output'

module JsonChecker
  class JSONValidator
    def self.validate_with_config(config)
      
      files = config['files']
      
      if files.nil? || files.empty?
        puts "[ERROR] Invalid json"
        return
      end
      
      files.each do |file|
        fileToCheck = JSONToCheck.new(file)
        
        fileContent = fileToCheck.get_content()   
        
        unless fileToCheck.keys.nil?
          title = "Validating #{fileToCheck.name} values"
          jsonValidator = JSONValidator.new()
          jsonValidator.validate_JSON_with_keys(title, fileToCheck.keys, fileContent)
        end
        
        unless fileToCheck.compareTo.nil?
          JSONComparator.compare(fileToCheck, fileToCheck.compareTo)
        end
      end
      HTMLOutput.generate_output()
    end
    
      def validate_JSON_with_keys(title, jsonKeys, json)
        items = Array.new()
        jsonKeys.keys.each do |key|
            value = value_for_key(key, json)
            expected = jsonKeys[key]
            items << verify_value(expected, value, key)
        end
        if items.size > 0
          HTMLOutput.add_validation_item(title, items)
        end
    end
    
    def value_for_key(key, json)
        return value_for_key_with_split_character(key, json, '.')
    end
    
    def is_numeric?(obj) 
     obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
    end
    
    def value_for_key_with_split_character(key, json, splitCharacter)
        value = json
        key.split(splitCharacter).each do |item|
            if !value.nil? && !item.empty?
              value = is_numeric?(item) ? value[item.to_i] : value[item]
            end
        end
        return value
    end
    
    def verify_value(expected, value, key)
        formatter = "<tr><td>%{first}</td><td>%{second}</td><td>%{third}</td><td>%{fourth}</td></tr>"
        result = "Error"
        if value.nil?
          result = "Not found"
        elsif value == expected
          result = "Success"
        end
        return formatter % {first: result, second: key, third:expected, fourth:value}
    end
  end
end