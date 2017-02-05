require "./ruby-test-object.rb"

# Printing values
puts "Hello world"

# Using variables
variable = 10
puts "Variable: #{variable}"
variable = variable + 5
puts "Variable after: #{variable}"

# Printing values with format
formatter = "%{first} %{second} %{third} %{fourth}"
puts formatter % {first: 1, second: 2, third: 3, fourth: 4}
puts formatter % {first: "one", second: "two", third: "three", fourth: "four"}
puts formatter % {first: true, second: false, third: true, fourth: false}

# Inserting value from keyboard
#print "Inser a value :"
#value = gets.chomp
#print "Value inserted: #{value}\n"

# Inserting values as parameter 
# first, second, third = ARGV
# This parameters are passed in comand filename first second third

# Reading file
#filename = 'ruby-test.txt'
#txt = open(filename)
#print txt.read

# Working with methods
#def methodTest()
#    puts 'Method test in ruby!'
#end
#methodTest()

# Working with methods with parameters
#def methodWithVariable(firstValue)
#    puts "Fist value #{fistValue}\n"
#end

# Reading file with line
#def printLine(line, f)
#    puts "#{line}, #{f.gets.chomp}"
#end

#printLine(0, txt)
#printLine(1, txt)

# Methods with return
#def methodWithReturn()
#    return 100
#end

#puts "#{methodWithReturn()}"

# if end | if elsif else end | if else end

# FOR
#fruits = ['apples', 'oranges', 'pears', 'apricots']
#fruits.each do |fruit|
#  puts "A fruit of type: #{fruit}"
#end

# Using another file
people = People.new("Cicero", 25)
puts "#{people.getName()}"
puts "#{people.getAge()}"