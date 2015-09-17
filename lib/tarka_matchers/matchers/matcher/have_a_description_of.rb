require 'tarka_matchers/helpers/matcher/main'
#require 'tarka_matchers/helpers/matcher/expect_capture'
require 'awesome_print'

module TarkaMatchers
	module Matchers
		module Matcher
			class MatcherTarget
				def target target, block_target, active_matcher
					@active_matcher = active_matcher
					#ap "helllo #{active_matcher}"
					if target.length > 0
					else
						block_target.call
					end
					self
				end

				def to matcher
					@matcher = matcher.description
					@active_matcher.actual_matcher = @matcher
				end

				alias_method :to_not, :to
				end

				def	have_a_description_of expected			
					HaveADescriptionOf.new expected
				end

				class HaveADescriptionOf
					attr_writer :actual_matcher
					def initialize expected

					end

					
					def supports_block_expectations?
						true
					end

					def matches? actual
						#ap "here: #{self}"
						active_matcher = self
						rspec_matchers = ::RSpec::Matchers
						real_expect = rspec_matchers.instance_method :expect
						rspec_matchers.send :remove_method, :expect
						rspec_matchers.send(:define_method, :expect){ |*target, &block_target| MatcherTarget.new.target target, block_target, active_matcher }

						actual.call

						rspec_matchers.send :remove_method, :expect
						rspec_matchers.send(:define_method, :expect, real_expect)

						ap @actual_matcher
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
