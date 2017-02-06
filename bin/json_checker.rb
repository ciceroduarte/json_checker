require './lib/json_fetcher.rb'
require './lib/json_validator.rb'

jsonConfig = JSONFetcher.json_from_path('json-config.json')

if !jsonConfig.nil?
  JSONValidator.validate_with_config(jsonConfig)
else 
  puts "[ERROR] json-config.json not found"
end