def mock_formatter klass, method_name, mocked_message
	clone_name = :c
	klass.define_singleton_method(clone_name, klass.singleton_method(method_name).unbind)
	klass.instance_variable_set(:@x, [mocked_message,clone_name])
	klass.define_singleton_method(method_name) do |expected,actual|
		caller[0].split('').last(9).join == "matches?'" ? @x[0] : self.send(@x[1],expected,actual)
	end
end
