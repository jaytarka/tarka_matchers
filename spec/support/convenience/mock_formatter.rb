def mock_formatter klass, method_name, mocked_message
	clone_name = :c80efee20bc1abb65ac0f9f236d0fbe33
	unless klass.methods.include?(clone_name)
		klass.define_singleton_method(clone_name, klass.singleton_method(method_name).unbind)
		klass.instance_variable_set(:@x28ea25b217d5eb29faee68c7195fad73, [mocked_message,clone_name])
		klass.define_singleton_method(method_name) do |expected,actual|
			caller[1].include?("`handle_failure'") ? self.send(@x28ea25b217d5eb29faee68c7195fad73[1], expected, actual) : @x28ea25b217d5eb29faee68c7195fad73[0]
		end
	end
end
