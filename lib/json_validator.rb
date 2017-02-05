require "rubygems"
require 'json'
require './lib/json_to_check.rb'
require './lib/json_fetcher.rb'
require './lib/json_comparator.rb'

class JSONValidator
  
  def self.validate_with_config(config)
    
    config['files'].each do |file|
      fileToCheck = JSONToCheck.new(file)
      
      fileContent = ""      

      if !fileToCheck.path.nil?
        fileContent = JSONFetcher.json_from_path(fileToCheck.path)
      elsif !fileToCheck.remotePath.nil?
        fileContent = JSONFetcher.json_from_url(fileToCheck.remotePath)
      else
        puts "[ERROR] path or remote-path not found"
        return
      end      
      
      puts "##############"
      puts "# VALIDATING #"
      puts "##############"
      
      jsonValidator = JSONValidator.new()
      jsonValidator.validate_JSON_with_keys(fileToCheck.keys, fileContent)
      
      JSONComparator.compare(fileContent, fileToCheck.compareTo)
      
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