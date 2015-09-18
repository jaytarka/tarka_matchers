require 'tarka_matchers/helpers/matcher/main'
module TarkaMatchers
	module Matchers
		module Matcher
			def	self.have_a_failure_message_when_negated_of expected
				HaveAFailureMessageWhenNegatedOf.new expected 
			end

			class HaveAFailureMessageWhenNegatedOf
				def initialize expected
					@expected = expected
				end
				attr_writer :actual_matcher
				def supports_block_expectations?
					true
				end

				def matches? actual
					active_matcher = self
					# @actual = TarkaMatchers::Helpers::Matcher::CaptureTargetMatcher.capture(actual, active_matcher).failure_message_when_negated.prepend 'should not'
					rspec_matchers = ::RSpec::Matchers
					real_expect = rspec_matchers.instance_method :expect
					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect){ |*target, &block_target| TarkaMatchers::Helpers::Matcher::ExpectCapture.new target, block_target, active_matcher }

					actual.call

					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect, real_expect)
					
					@expected == @actual_matcher.failure_message_when_negated
				end

				def description	
					"have a failure message when negated of #{@expected}."
				end
				
				def report
					"expected a failure message when negated of '#{@expected}'. Got a failure message when negated of '#{@actual}'"
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
