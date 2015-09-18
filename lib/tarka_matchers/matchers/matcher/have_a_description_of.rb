require 'tarka_matchers/helpers/matcher/expect_capture'

module TarkaMatchers
	module Matchers
		module Matcher	
			def	have_a_description_of expected			
				HaveADescriptionOf.new expected
			end

			class HaveADescriptionOf
				attr_writer :actual_matcher

				def initialize expected
					@expected = expected
				end

				def supports_block_expectations?
					true
				end

				def matches? actual
					@actual_matcher = TarkaMatchers::Helpers::Matcher::ExpectCapture.capture(actual)
					@actual = @actual_matcher.description.prepend 'should '
					@actual == @expected
				end

				def description	
					"utilize a matcher, '#{@actual_matcher.class}', that has a description of '#{@expected}'."
				end
				
					def report
					"The matcher has a description of '#{@actual}'."
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
