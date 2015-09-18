def foo_up_to expected
	FooUpTo.new expected
end

class FooUpTo
	def initialize expected
		@expected = expected
	end

	def matches? actual
		@actual = actual
		@actual == @expected
	end

	def description
		"faz around."
	end

	def report
		"Expected #{@expected}, got #{@actual}."
	end

	def failure_message
		"foo around. #{report}"
	end

	def failure_message_when_negated
		"fiz around. #{report}"
	end

	def supports_block_expectations?
		false
	end
end
