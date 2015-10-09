def mock_formatter klass, method_name, mocked_message
	clone_name = :c80efee20bc1abb65ac0f9f236d0fbe33
	unless klass.methods.include?(clone_name)
		klass.define_singleton_method(clone_name, klass.singleton_method(method_name).unbind)
		klass.instance_variable_set(:@x28ea25b217d5eb29faee68c7195fad73, [mocked_message,clone_name])
		klass.define_singleton_method(method_name) do |expected,actual|
			caller.map{ |v| v.split('').last(9).join == "matches?'" }.include?(true) ? @x28ea25b217d5eb29faee68c7195fad73[0] : self.send(@x28ea25b217d5eb29faee68c7195fad73[1], expected, actual)
		end
	end
end
