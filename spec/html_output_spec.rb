require "spec_helper"
require "json_checker/html_output"

RSpec.describe JsonChecker::HTMLOutput do
  
  it "json comparator don't broken with a invalid report" do
    htmlOutput = JsonChecker::HTMLOutput.new
    htmlOutput.save_to_file(nil)
  end

  it "json comparator don't broken with a invalid values" do
    JsonChecker::HTMLOutput.add_comparation_item(nil, nil)
  end

  it "json comparator don't broken with a valid values" do
    JsonChecker::HTMLOutput.add_comparation_item("test", "test")
  end

end
