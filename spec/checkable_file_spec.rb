require "spec_helper"
require "json_checker/checkable_file"

RSpec.describe JsonChecker::CheckableFile do
  
  it "return false for invalid representation" do
    expect(JsonChecker::CheckableFile.is_valid_representation?("{}")).not_to be true
  end

  it "return nil for get_content" do
  	checkableFile = JsonChecker::CheckableFile.new("{}") 
  	expect(checkableFile.get_content()).to be nil
  end 
  
end
