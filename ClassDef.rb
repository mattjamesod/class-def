require 'json'
require './Property.rb'

def parseArgs
	if ARGV.size < 1
		puts "JSON not specified. Options:\n\n--inline \"{\\\"some\\\":\\\"value\\\"}\"\n--dir path/to/some/data.json"
		exit
	end
	
	if ["-inline","-i"].include?(ARGV[0])
		return ARGV[1]
	end
	
	if ["-directory","-dir","-d"].include?(ARGV[0])
		puts "Not implemented! Sorry."
		exit
	end
end

T_SWIFT_STRUCT = "struct STRUCT_NAME {PROP_LIST\n}"
T_SWIFT_PROPERTY = "\n    var PROP_NAME: PROP_TYPE"

def generateSwiftStruct(props)
	property_list = props
		.map do |prop| 
			T_SWIFT_PROPERTY
				.gsub("PROP_NAME", prop.name)
				.gsub("PROP_TYPE", prop.type) 
		end
		.reduce(:+)

	return T_SWIFT_STRUCT
		.sub("STRUCT_NAME", "GeneratedStruct")
		.sub("PROP_LIST", property_list)
end

json = parseArgs

json_hash = JSON.parse(json)

json_hash.map { |key, value| puts "#{key} - #{value}" }

root_keys = json_hash.keys
root_values = json_hash.values

puts generateSwiftStruct(root_keys.map{ |key| Property.new(key, "String")})