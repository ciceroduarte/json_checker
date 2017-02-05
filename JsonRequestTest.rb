# https://app.servicos.uol.com.br/aplicativo/uol/configs?app=bol-mail&v=1.9.0&p=iphone&so=9.2&r=retina
require 'net/http'
require 'json'
require "json-diff"
require './lib/RemoteItem.rb'
require './JsonChecker.rb'

def json_from_path(path)
  jsonFile = open(path)
  jsonContent = jsonFile.read
  return JSON.parse(jsonContent)
end

def json_from_url(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  return JSON.parse(response)
end

def fetch_remotes(remotes)
  result = Array.new
  remotes.each do |item|
    if RemoteItem.isValidRepresentation(item)
      remote = RemoteItem.new(item)
      response = json_from_url(remote.url)
    remote.content = response
    result.insert(-1, remote)
    end
  end

  return result
end

def upper_content(title)
  return "<html>
  <head>
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css\">
    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js\"></script>
    <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js\"></script>
  </head>
  <body>
  <div class=\"container\">
  <h2>#{title}</h2>
  <div class=\"panel-group\">
    <div class=\"panel panel-default\">
      <div class=\"panel-heading\">
        <div class=\"panel-group\">"
end

def bottom_content()
  return "
  </div>
  </div>
  </div>
  </div>
  </div>
  </body>
  </html>"
end

def add_item_to_group(type, change, name)
  return "
      <div class=\"panel panel-default\">
        <div class=\"panel-heading\">
          <h4 class=\"panel-title\">
            <a data-toggle=\"collapse\" href=\"##{name}\">#{type}</a>
           </h4>
        </div>
        <div id=\"#{name}\" class=\"panel-collapse collapse\">
          <div class=\"panel-body\">#{change}</div>
        </div>
      </div>"
end

def diff_json(firstJson, secondJson)
  jsonChecker = JsonChecker.new()
  diff = JsonDiff.diff(firstJson.content, secondJson.content)

  output = upper_content("Comparing #{firstJson.name} with #{secondJson.name}")

  diff.each_with_index do |jsonDiff, index|
    op = jsonDiff["op"]
    puts op

    path = jsonDiff["path"]
    value = jsonChecker.valueFromKeyWithSplitCharacter(path, firstJson.content, "/")
    result = ""

    if op === "replace"
      puts "New value: #{value}"
      puts "Old value: #{jsonDiff["value"]}"
      result = "#{jsonDiff["value"]} changed to #{value}"
    else
      result = "Value: #{value}"
      puts "Value: #{value}"
    end
    puts "For key: #{path}"
    result = result + "<br>For key: #{path}"

    output = output + add_item_to_group(op, result, "#{firstJson.name}#{index}")
  end
  return output = output + bottom_content()
end

jsonConfig = json_from_path('json-config.json')

remoteContent = jsonConfig['remote']

if !remoteContent.nil?

  remotes = fetch_remotes(remoteContent)
  content = ""
  remotes.each do |actualItem|
    remotes.each do |item|
      if item != actualItem
        content = content + diff_json(actualItem, item)
      end
    end
  end
  File.write("comparation.html", content)
end