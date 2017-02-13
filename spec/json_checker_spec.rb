require "spec_helper"

RSpec.describe JsonChecker do
  it "has a version number" do
    expect(JsonChecker::VERSION).not_to be nil
  end

  it "Checker is running" do
  	checker = JsonChecker::Checker.new
  	checker.run()
  end
  
end
