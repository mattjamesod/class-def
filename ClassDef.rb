require 'json'
require './Property.rb'

def parse_args
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

def generate_swift_struct(props)
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

def get_swift_type_of(value)
	return "Int" if value.is_a? Integer

	return "String"
end

json_hash = JSON.parse(parse_args)

props = json_hash.map do |key, value|
	Property.new(key, get_swift_type_of(value))
end

puts generate_swift_struct(props)