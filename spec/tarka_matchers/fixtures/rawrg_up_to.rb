def rawrg_up_to expected
	RawrgUpTo.new expected
end

class RawrgUpTo
	def initialize expected
		@expected = expected
	end

	def matches? actual
		@actual = actual
		@actual == @expected
	end

	def description
		"rawrg around."
	end

	def report
		"Expected #{@expected}, got #{@actual}."
	end

	def failure_message
		"rwarg around. #{report}"
	end

	def failure_message_when_negated
		"rawr around. #{report}"
	end
end
