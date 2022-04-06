require 'json'

def parseArgs
	if ARGV.size < 1
		puts "JSON not specified. Options:\n\n--inline \"{\\\"some\\\":\\\"value\\\"}\"\n--dir path/to/some/data.json"
		exit
	end
	
	if ["--inline","--i"].include?(ARGV[0])
		return ARGV[1]
	end
	
	if ["--directory","--dir","--d"].include?(ARGV[0])
		puts "Not implemented! Sorry."
		exit
	end
end

json = parseArgs
parsed_json = JSON.parse(json)

root_keys = parsed_json.keys

swift_keys = root_keys
	.map { |key| "var #{key}: String\n" }
	.reduce { |key_list, key| "#{key_list}    #{key}" }

swift_struct_def = "struct GeneratedStruct {\n    #{swift_keys}}"

puts swift_struct_def