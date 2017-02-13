require "spec_helper"
require "json_checker/json_validator"

RSpec.describe JsonChecker::JSONValidator do
  
  it "return nil with invalid config" do
  	result = JsonChecker::JSONValidator.validate_with_config("{}")
    expect(result).to be nil
  end

end
