class SwiftStructGenerator
	T_STRUCT = "struct STRUCT_NAME {PROP_LIST\n}"
	T_PROPERTY = "\n    var PROP_NAME: PROP_TYPE"
	
	def generate_struct(props, name = "GeneratedStruct")
		puts props.map { |p| p.name + " " }.reduce(:+)

		nested_props = props
			.filter { |prop| !prop.type.is_a? String }
			.uniq
			#.map { |prop| prop.type }
			.each_with_index
			.to_h { |prop, index|  ["NestedStruct#{index}", prop.type] }

		# puts nested_props.inspect
		# puts nested_props.first[1].first.inspect

		root_property_list = props
			.filter { |prop| prop.type.is_a? String }
			.map do |prop| 
				T_PROPERTY
					.gsub("PROP_NAME", prop.name)
					.gsub("PROP_TYPE", (prop.type.is_a? String) ? prop.type : (nested_props.filter { |n| n[1] == prop.type }.first[0]) ) 
			end
			.reduce(:+)
	
		return T_STRUCT
			.sub("STRUCT_NAME", "GeneratedStruct")
			.sub("PROP_LIST", root_property_list)
	end

	def get_array_type_of(value)
		return nil unless value.is_a? Array #value.match("/\[.+\]/s")

		get_type_of(value[0])
	end
	
	def get_type_of(value)
		return "[#{get_array_type_of(value)}]" if value.is_a? Array

		return "Bool" if (value === true || value === false)

		return "Int" if value.is_a? Integer
	
		return "String" if value.is_a? String

		value.map do |key, value|
			Property.new(key, get_type_of(value))
		end
	end
end