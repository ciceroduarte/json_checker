require "spec_helper"
require "json_checker/json_comparator"
require "json_checker/checkable_file"

RSpec.describe JsonChecker::JSONComparator do

  it "json comparator don't broken with nil values" do
  	JsonChecker::JSONComparator.compare(nil, nil)
  end

  it "json comparator don't broken with invalid values" do
  	JsonChecker::JSONComparator.compare("invalid value", "invalid value")
  end

  it "json comparator don't broken with invalid array" do
  	JsonChecker::JSONComparator.compare("invalid value", [1, 2])
  end

  it "json comparator don't broken with invalid json" do
  	JsonChecker::JSONComparator.compare("invalid value", ["{\"name\" : \"teste\"}"])
  end

  it "json comparator don't broken with valid json" do
  	JsonChecker::JSONComparator.compare("invalid value", ["{\"name\" : \"teste\", \"path\": \"tmp/test\"}"])
  end

  it "json comparator don't broken with a checkableFile and a valid json" do
  	representation = "{\"name\" : \"teste\", \"path\": \"tmp/test\"}"
  	checkableFile = JsonChecker::CheckableFile.new(representation)

  	JsonChecker::JSONComparator.compare(checkableFile, ["{\"name\" : \"teste\", \"path\": \"tmp/test\"}"])
  end

  it "json comparator don't broken with a checkableFile and a invalid value" do
  	representation = "{\"name\" : \"teste\", \"path\": \"tmp/test\"}"
  	checkableFile = JsonChecker::CheckableFile.new(representation)

  	JsonChecker::JSONComparator.compare(checkableFile, "invalid value")
  end

  it "html_report_from_diff return nil for a invalid diff" do
  	jsonComparator = JsonChecker::JSONComparator.new()
  	report = jsonComparator.html_report_from_diff(nil) 
  	expect(report).to be nil
  end 

  it "add_line don't broken with a invalid line" do
  	jsonComparator = JsonChecker::JSONComparator.new()
  	jsonComparator.add_line(nil)
  end 

  it "add_line don't broken with a empty line" do
  	jsonComparator = JsonChecker::JSONComparator.new()
  	jsonComparator.add_line("")
  end 

  it "add_line don't broken with a valid line" do
  	jsonComparator = JsonChecker::JSONComparator.new()
  	jsonComparator.add_line("test")
  end 

end