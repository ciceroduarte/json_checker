require "json_checker/version"
require 'json_checker/json_fetcher'
require 'json_checker/json_validator'

module JsonChecker

	jsonConfig = JSONFetcher.json_from_path('json-config.json')

	unless jsonConfig.nil?
  		JSONValidator.validate_with_config(jsonConfig)
	end
end