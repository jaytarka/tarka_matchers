require 'tarka_matchers/formatters/difference'
require 'tarka_matchers/helpers/expectation/expect_capture'
require 'tarka_matchers/helpers/expectation/common'
module TarkaMatchers
	module Matchers
		module Expectation
			def	have_a_description_of expected			
				HaveADescriptionOf.new expected
			end

			class HaveADescriptionOf
				include TarkaMatchers::Helpers::Expectation::Common
				def initialize expected
					@expected = expected
				end

				def supports_block_expectations?
					true
				end

				def matches? actual
					captured = TarkaMatchers::Helpers::Expectation::ExpectCapture.capture(actual)
					@actual_matcher = captured[1]
					@actual = escape(@actual_matcher.description.prepend captured[0])
					clean!(@actual)
					@actual == @expected
				end

				def description	
					"utilize a matcher that has a description of: '#{@expected}'"
				end
			
				def failure_message
					"The matcher, '#{@actual_matcher.class}', does not have the expected description: #{TarkaMatchers::Formatters::Difference.difference(@expected,@actual)}"
				end

				def failure_message_when_negated
					"#{description}"
				end
			end
		end
	end
end
