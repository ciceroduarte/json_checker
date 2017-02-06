require "rubygems"
require 'json'
require 'net/http'

class JSONFetcher
  
  def self.json_from_path(path)
    if File.file?(path)
      jsonFile = open(path)  
      jsonContent = jsonFile.read
      return JSON.parse(jsonContent)
    end
    return nil
  end
  
  def self.json_from_url(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return JSON.parse(response)
  end
  
end