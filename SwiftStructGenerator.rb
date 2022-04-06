class SwiftStructGenerator
	T_STRUCT = "struct STRUCT_NAME {PROP_LIST\n}"
	T_PROPERTY = "\n    var PROP_NAME: PROP_TYPE"
	
	def generate_struct(props)
		property_list = props
			.map do |prop| 
				T_PROPERTY
					.gsub("PROP_NAME", prop.name)
					.gsub("PROP_TYPE", prop.type) 
			end
			.reduce(:+)
	
		return T_STRUCT
			.sub("STRUCT_NAME", "GeneratedStruct")
			.sub("PROP_LIST", property_list)
	end
	
	def get_type_of(value)
		return "Bool" if (value === true || value === false)

		return "Int" if value.is_a? Integer
	
		return "String"
	end
end