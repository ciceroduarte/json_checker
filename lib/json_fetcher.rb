require "rubygems"
require 'json'
require 'net/http'

class JSONFetcher
  
  def self.json_from_path(path)
    if File.file?(path)
      jsonFile = open(path)
      jsonContent = jsonFile.read
      return JSONFetcher.json_from_content(jsonContent)
    end
    return nil
  end
  
  def self.json_from_url(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    case response
      when Net::HTTPSuccess then
      return JSONFetcher.json_from_content(response.body)
    else
      puts"[ERROR] Connection error"
    end
    return nil
  end
  
  def self.json_from_content(content)
    begin
      return JSON.parse(content)
    rescue JSON::ParserError => e
      puts "[ERROR] Invalid json"
    end
    return nil
  end
  
end