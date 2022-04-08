class SwiftStructGenerator
	T_STRUCT = "struct STRUCT_NAME {PROP_LIST\n}\n\n"
	T_PROPERTY = "\n    var PROP_NAME: PROP_TYPE"
	
	def generate_struct(props, name = "GeneratedStruct")
		root_property_list = props
			.map do |prop| 
				T_PROPERTY
					.gsub("PROP_NAME", prop.name)
					.gsub("PROP_TYPE", (prop.type.is_a? String) ? prop.type : prop.nested_type_name) 
			end
			.reduce(:+)
	
		root_struct = T_STRUCT
			.sub("STRUCT_NAME", name)
			.sub("PROP_LIST", root_property_list)

		nested_structs = props
			.filter { |prop| !prop.type.is_a? String }
			.map { |prop| generate_struct(prop.type, prop.nested_type_name) }

		return root_struct + (nested_structs.reduce(:+) || "")
	end

	def map_properties(hash)
		hash.map do |key, value|
			Property.new(key, get_type_of(value))
		end
	end

	private

	def get_array_type_of(value)
		return nil unless value.is_a? Array

		get_type_of(value[0])
	end
	
	def get_type_of(value)
		return "[#{get_array_type_of(value)}]" if value.is_a? Array

		return "Bool" if (value === true || value === false)

		return "Int" if value.is_a? Integer
	
		return "String" if value.is_a? String

		# nested struct
		map_properties(value)
	end
end