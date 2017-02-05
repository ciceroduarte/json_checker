require './lib/json_fetcher.rb'
require './lib/json_validator.rb'

jsonConfig = JSONFetcher.json_from_path('json-config.json')
JSONValidator.validate_with_config(jsonConfig)
