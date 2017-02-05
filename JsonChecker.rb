require "rubygems"
require 'json'

#file1, file2 = ARGV

class JsonChecker

  def verifyJSON(jsonConfig, json)
      jsonConfig.keys.each do |key|
          value = valueFromKey(key, json)
          configValue = jsonConfig[key]
          verifyValues(configValue, value, key)
      end
  end
  
  def valueFromKey(key, json)
      puts '--------------------------------'
      puts "Start searching for key #{key}"
      puts '--------------------------------'
      return valueFromKeyWithSlipCharacter(key, json, '.')
  end
  
  def is_numeric?(obj) 
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
  
  def valueFromKeyWithSplitCharacter(key, json, splitCharacter)
      value = json
      key.split(splitCharacter).each do |item|
          if !value.nil? && !item.empty?
            
            value = is_numeric?(item) ? value[item.to_i] : value[item]
            
          end
      end
      return value
  end
  
  def verifyValues(configValue, value, key)
      formatter = "Status %{first}\nKey %{second}\nExpected value: %{third}\nValue: %{fourth}"
      result = "Fail"
      if value.nil?
          result = "Not found"
      elsif value == configValue
          result = "Success"
      end
      puts formatter % {first: result, second: key, third: configValue, fourth:value}
  end
  
  def jsonFromPath(path)
    jsonFile = open(path)
    jsonContent = jsonFile.read
    return JSON.parse(jsonContent)
  end
  
end

# jsonConfig = jsonFromPath('json-config.json')
# jsonToVerify = jsonFromPath('json-to-verify.json')
# 
# verifyJSON(jsonConfig, jsonToVerify)