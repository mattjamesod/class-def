require 'json'
require './Property.rb'
require './SwiftStructGenerator.rb'

def parse_args
	if ARGV.size < 1
		puts "JSON not specified. Options:\n\n--inline \"{\\\"some\\\":\\\"value\\\"}\"\n--dir path/to/some/data.json"
		exit
	end
	
	if ["-inline","-i"].include?(ARGV[0])
		return ARGV[1]
	end
	
	if ["-directory","-dir","-d"].include?(ARGV[0])
		return File.open(ARGV[1]).read
	end

	#--hard: replace the json file with the new struct defintion
	#--with-defaults: use the values in the json as default values in the generated struct
end

json_hash = JSON.parse(parse_args)

generator = SwiftStructGenerator.new()

puts generator.generate_struct(json_hash)