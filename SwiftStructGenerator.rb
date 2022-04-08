class SwiftStructGenerator
	T_STRUCT = "struct STRUCT_NAME: Codable {PROP_LIST\n}\n\n"
	T_PROPERTY = "\n    var PROP_NAME: PROP_TYPE"
	
	def generate_struct(hash, name = "GeneratedStruct")
		props = map_properties(hash)
		generate_struct_from_props(props, name)
	end

	private

	def generate_struct_from_props(props, name)
		root_property_list = props
			.map do |prop| 
				T_PROPERTY
					.gsub("PROP_NAME", prop.name)
					.gsub("PROP_TYPE", prop.type_name) 
			end
			.reduce(:+)
	
		root_struct = T_STRUCT
			.sub("STRUCT_NAME", name)
			.sub("PROP_LIST", root_property_list)

		nested_structs = props
			.filter { |prop| !prop.signature.is_a? String }
			.map { |prop| generate_struct_from_props(prop.signature, prop.nested_signature_name) }

		return root_struct + (nested_structs.reduce(:+) || "")
	end

	def map_properties(hash)
		return get_signature_of(hash[0]) if hash.is_a? Array

		hash.map do |key, value|
			Property.new(key, get_signature_of(value), (value.is_a? Array))
		end
	end
	
	def get_signature_of(value)
		return "Bool" if (value === true || value === false)

		return "Int" if value.is_a? Integer
	
		return "String" if value.is_a? String

		return "String" if value.nil?

		# nested struct
		map_properties(value)
	end
end