class Property
	attr_accessor :name, :signature

	def initialize(name, signature)
		@name = name
		@signature = signature
	end

	def nested_signature_name
		"Generated#{name.capitalize}Struct"
	end
end