require "spec_helper"
require "json_checker/json_validator"

RSpec.describe JsonChecker::JSONValidator do
  
  it "return nil with invalid config" do
  	result = JsonChecker::JSONValidator.validate_with_config("{}")
    expect(result).to be nil
  end

  it "don't broken with invalid path" do
  	jsonValidator = JsonChecker::JSONValidator.new()

  	jsonContent = "{\"array\": [ {\"item1\":\"item1\"}, {\"item2\":\"item2\"} ]}"
	json = JsonChecker::JSONFetcher.json_from_content(jsonContent)

  	result = jsonValidator.value_for_key_with_split_character("array.item2", json, ".")
  	expect(result).to be nil
  end

  it "return value for key" do
  	jsonValidator = JsonChecker::JSONValidator.new()

  	jsonContent = "{ \"array\": [ {\"item1\":\"item1\"}, {\"item2\":\"item2\"} ] }"
	json = JsonChecker::JSONFetcher.json_from_content(jsonContent)
	
  	result = jsonValidator.value_for_key_with_split_character("array.1.item2", json, ".")
  	expect(result).to eql("item2")
  end

end
