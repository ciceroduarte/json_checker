require "rubygems"
require 'json'

#file1, file2 = ARGV

def verifyJSON(jsonConfig, json)
    jsonConfig.keys.each do |key|
        value = valueFromKey(key, json)
        configValue = jsonConfig[key]
        verifyValues(configValue, value, key)
    end
end

def valueFromKey(key, json)
    value = json
    key.split('.').each do |item|
        value = value[item]
    end
    return value
end

def verifyValues(configValue, value, key)
    formatter = "Status %{first}\nKey %{second}\nConfig value: %{third}\nValue: %{fourth}"
    result = "Fail"
    if value == configValue
        result = "Success"
    end
    puts '--------------------------------'
    puts formatter % {first: result, second: key, third: configValue, fourth:value}
end

jsonFileConfig = open('json-config.json')
jsonToVerify = open('json-to-verify.json')

#jsonFileConfig = open(file1)
#jsonToVerify = open(file2)

jsonFileContent = jsonFileConfig.read
jsonToVerifyContent = jsonToVerify.read

jsonFileConfig = JSON.parse(jsonFileContent)
jsonToVerify = JSON.parse(jsonToVerifyContent)

verifyJSON(jsonFileConfig, jsonToVerify)