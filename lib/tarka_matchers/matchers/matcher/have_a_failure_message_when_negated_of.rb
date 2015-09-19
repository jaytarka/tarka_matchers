require 'tarka_matchers/helpers/matcher/expect_capture'
module TarkaMatchers
	module Matchers
		module Matcher
			def	have_a_failure_message_when_negated_of expected
				HaveAFailureMessageWhenNegatedOf.new expected
			end

			class HaveAFailureMessageWhenNegatedOf
				def initialize expected
					@expected = expected
				end

				def supports_block_expectations?
					true
				end

				def matches? actual
					@actual_matcher = TarkaMatchers::Helpers::Matcher::ExpectCapture.capture(actual)[1]
					@actual = @actual_matcher.failure_message_when_negated
					@actual == @expected
				end

				def description	
					"fail."
				end
			
				def report
					"Spec result: #{@actual}"
				end

				def failure_message
					"#{description} #{report}"
				end

				def failure_message_when_negated
					"#{description} #{report}"
				end
			end
		end
	end
end
