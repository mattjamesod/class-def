class Property
	attr_accessor :name, :type

	def initialize(name, type)
		@name = name
		@type = type
	end

	def nested_type_name
		"Generated#{name.capitalize}Struct"
	end
end