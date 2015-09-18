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
					# @actual = TarkaMatchers::Helpers::Matcher::ExpectCapture.capture(actual, active_matcher).supports_block_extensions?
					rspec_matchers = ::RSpec::Matchers
					real_expect = rspec_matchers.instance_method :expect
					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect){ |*target, &block_target| TarkaMatchers::Helpers::Matcher::ExpectCapture.new target, block_target, active_matcher }

					actual.call

					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect, real_expect)
					ap @actual_matcher	
					ap @actual_mathcer.class
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
					message = "Expected the matcher '#{@actual_matcher.class}' to contain the method supports_block_expectations? method and for it to return 'true'. "
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
