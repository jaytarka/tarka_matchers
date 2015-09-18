require 'tarka_matchers/helpers/matcher/expect_capture'

module TarkaMatchers
	module Matchers
		module Matcher	
			def	support_block_expectations
				SupportBlockExpectations.new
			end

			class SupportBlockExpectations
				attr_writer :actual_matcher
				def supports_block_expectations?
					true
				end

				def matches? actual
					active_matcher = self
					rspec_matchers = ::RSpec::Matchers
					real_expect = rspec_matchers.instance_method :expect
					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect){ |*target, &block_target| TarkaMatchers::Helpers::Matcher::ExpectCapture.new target, block_target, active_matcher }

					actual.call

					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect, real_expect)
					
					@exist = true
					begin
						@actual = @actual_matcher.supports_block_expectations?
					rescue NoMethodError 
						@exist = false
					end
					@actual == true
				end

				def description	
					"support block expectations."
				end
				
					def report
					message = "Expected the matcher to contain the method supports_block_expectations? method and for it to return to true. "
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
