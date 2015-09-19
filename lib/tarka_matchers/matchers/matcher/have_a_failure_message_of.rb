require 'tarka_matchers/helpers/matcher/expect_capture'
module TarkaMatchers
	module Matchers
		module Matcher
			def	have_a_failure_message_of expected
				HaveAFailureMessageOf.new expected
			end

			class HaveAFailureMessageOf
				def initialize expected
					@expected = expected
				end

				def supports_block_expectations?
					true
				end

				def matches? actual
					@actual_matcher = TarkaMatchers::Helpers::Matcher::ExpectCapture.capture(actual)[1]
					@actual = @actual_matcher.failure_message
					@actual == @expected
				end

				def description	
					"utilize a matcher, '#{@actual_matcher.class}', that has a failure message of '#{@expected}'."
				end
				
				def report
					"The matcher has a failure messsage when negated of '#{@actual}'."
				end

				def failure_message
					"failed to #{description} #{report}"
				end

				def failure_message_when_negated
					"#{description} #{report}"
				end
			end
		end
	end
end
