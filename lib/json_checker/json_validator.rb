require "rubygems"
require 'json'
require 'json_checker/json_to_check'
require 'json_checker/json_fetcher'
require 'json_checker/json_comparator'

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
          puts " Validating #{fileToCheck.name} values"
        
          jsonValidator = JSONValidator.new()
          jsonValidator.validate_JSON_with_keys(fileToCheck.keys, fileContent)  
        end
        
        unless fileToCheck.compareTo.nil?
          JSONComparator.compare(fileToCheck, fileToCheck.compareTo)
        end
      end
    end
    
      def validate_JSON_with_keys(jsonKeys, json)
        jsonKeys.keys.each do |key|
            value = value_for_key(key, json)
            configValue = jsonKeys[key]
            verify_value(configValue, value, key)
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
    
    def verify_value(configValue, value, key)
        formatter = "%{first} | Key: %{second} | Expected value: %{third} | Value: %{fourth}"
        result = "[Error]    "
        if value.nil?
            result = "[Not found]"
        elsif value == configValue
            result = "[Success]  "
        end
        puts formatter % {first: result, second: key, third: configValue, fourth:value}
    end
  end
end