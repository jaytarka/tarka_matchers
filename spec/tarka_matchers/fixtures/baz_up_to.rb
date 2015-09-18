def baz_up_to expected
	BazUpTo.new expected
end

class BazUpTo
	def initialize expected
		@expected = expected
	end

	def matches? actual
		@actual = actual
		actual.call if @actual.class == Proc
		@actual == @expected
	end

	def description
		"baz around."
	end

	def report
		"Expected #{@expected}, got #{@actual}."
	end

	def failure_message
		"boo around. #{report}"
	end

	def failure_message_when_negated
		"biz around. #{report}"
	end

	def supports_block_expectations?
		true
	end
end
