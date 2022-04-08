class Property
	attr_accessor :name, :signature, :is_array

	def initialize(name, signature, is_array = false)
		@name = name
		@signature = signature
		@is_array = is_array
	end

	def type_name
		base_name = (signature.is_a? String) ? signature : nested_signature_name
		is_array ? "[" + base_name + "]" : base_name
	end

	def nested_signature_name
		"Generated#{name.capitalize}Struct"
	end
end