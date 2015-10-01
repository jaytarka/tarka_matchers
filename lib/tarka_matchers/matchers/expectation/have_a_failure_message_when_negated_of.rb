require 'tarka_matchers/formatters/difference'
require 'tarka_matchers/helpers/expectation/expect_capture'
require 'tarka_matchers/helpers/expectation/common'
module TarkaMatchers
	module Matchers
		module Expectation
			def	have_a_failure_message_when_negated_of expected
				HaveAFailureMessageWhenNegatedOf.new expected
			end

			class HaveAFailureMessageWhenNegatedOf
				include TarkaMatchers::Helpers::Expectation::Common
				def initialize expected
					@expected = expected
				end

				def supports_block_expectations?
					true
				end

				def matches? actual
					@actual_matcher = TarkaMatchers::Helpers::Expectation::ExpectCapture.capture(actual)[1]
					@actual = clean!(escape(@actual_matcher.failure_message_when_negated))
					@actual == @expected
				end

				def description		
					"utilize a matcher that has a failure message when negated of: '#{@expected}'"
				end

				def failure_message
					"The matcher, '#{@actual_matcher.class}', does not have the expected failure message when negated: #{TarkaMatchers::Formatters::Difference.difference(@expected,@actual)}"
				end

				def failure_message_when_negated
					"#{description}"
				end
			end
		end
	end
end
