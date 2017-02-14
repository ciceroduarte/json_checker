require "rubygems"
require 'json'
require 'net/http'

module JsonChecker

  class JSONFetcher
  
    def self.json_from_path(path)
      begin
        jsonFile = open(path)
        jsonContent = jsonFile.read
        return JSONFetcher.json_from_content(jsonContent)
      rescue
        puts "[ERROR] #{path} not found"
        return nil
      end
    end
    
    def self.json_from_url(url)
      begin
        uri = URI(url)
        response = Net::HTTP.get_response(uri)
        return JSONFetcher.fetch_response(response)  
      rescue
      end
      
      return nil
    end
    
    def self.json_from_content(content)
      if content.nil? || (!content.is_a?(String) && (!content.is_a?(Hash)))
        return nil
      end

      begin
        return content.is_a?(String) ? JSON.parse(content) : JSON.parse(content.to_json)
      rescue JSON::ParserError => e
        puts "[ERROR] Invalid json"
      end
      return nil
    end

    def self.fetch_response(response)
      case response
        when Net::HTTPSuccess then
          return JSONFetcher.json_from_content(response.body)
        else
          puts"[ERROR] Connection error"
      end
    end

  end
end