require 'tarka_matchers/formatters/difference'
require 'tarka_matchers/helpers/expectation/expect_capture'
module TarkaMatchers
	module Matchers
		module Expectation
			def	have_a_description_of expected			
				HaveADescriptionOf.new expected
			end

			class HaveADescriptionOf
				def initialize expected
					@expected = expected
				end

				def supports_block_expectations?
					true
				end

				def matches? actual
					captured = TarkaMatchers::Helpers::Expectation::ExpectCapture.capture(actual)
					@actual_matcher = captured[1]
					@actual = @actual_matcher.description.prepend captured[0]
					@actual == @expected
				end

				def description	
					"utilize a matcher that has a description of: '#{@expected}'"
				end
			
				def failure_message
					"The matcher, '#{@actual_matcher.class}', does not have the expected description: #{TarkaMatchers::Formatters::Difference.difference(@actual,@expected)}"
				end

				def failure_message_when_negated
					"#{description}"
				end
			end
		end
	end
end
