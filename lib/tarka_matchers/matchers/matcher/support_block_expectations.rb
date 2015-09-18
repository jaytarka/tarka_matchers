require 'tarka_matchers/helpers/matcher/expect_capture'
module TarkaMatchers
	module Matchers
		module Matcher	
			def	support_block_expectations
				SupportBlockExpectations.new
			end

			class SupportBlockExpectations
				def supports_block_expectations?
					true
				end

				def matches? actual
					@actual_matcher = TarkaMatchers::Helpers::Matcher::ExpectCapture.capture(actual)
					@exist = true
					begin
						@actual = @actual_matcher.supports_block_expectations?
					rescue NoMethodError 
						@exist = false
					end
					@actual == true
				end

				def description	
					"utilize a matcher, '#{@actual_matcher.class}', that supports block expectations."
				end
				
					def report
					message = "Expected the matcher, '#{@actual_matcher.class}', to contain the method supports_block_expectations? method and for it to return 'true'. "
					@exist ? message << "Instead it returned '#{@actual}'." : message << "The supports_block_expectations? method does not exist inside the matcher. (Hint: check spelling)"
					message
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
