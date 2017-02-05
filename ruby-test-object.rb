require "rubygems"
require 'json'

#class People
#
#    def initialize(name, age)
#        @name = name
#        @age = age
#    end
#
#    def getName()
#        return @name
#    end
#    
#    def getAge()
#        return @age
#    end
#    
#end
#
#people = People.new("Cicero", 25)
#puts "#{people.getName()}"
#puts "#{people.getAge()}"

filename = 'jsonfile.json'
txt = open(filename)
json = txt.read

jsonDocument = JSON.parse(json)
puts jsonDocument
puts jsonDocument["name"]