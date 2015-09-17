require 'tarka_matchers/helpers/matcher/main'
#require 'tarka_matchers/helpers/matcher/expect_capture'
require 'awesome_print'

module TarkaMatchers
	module Matchers
		module Matcher
			class MatcherTarget
				def target target, block_target, real_expect, expected
					@expected = expected
					@real_expect = real_expect
					if target.length > 0
					 ap target
					else
						block_target.call
					end
					self
				end

				def to matcher
					ap 'twice':
					@matcher = matcher	
					HaveADescriptionOf.new matcher, @expected, @real_expect
				end

					def supports_block_expectations?
						true
					end
				alias_method :to_not, :to
		end

				def	have_a_description_of expected			
					ap 'matcher called'
					rspec_matchers = ::RSpec::Matchers
					real_expect = rspec_matchers.instance_method :expect
					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect){ |*target,&block_target| MatcherTarget.new.target target, block_target, real_expect, expected }
					'hello'
				end

				class HaveADescriptionOf
					def initialize matcher, expected, real_expect
						@description = matcher.description
						@expected = expected
						ap @description
						rspec_matchers = ::RSpec::Matchers
						real_expect = rspec_matchers.instance_method :expect
				#		rspec_matchers.send :remove_method, :expect
				#		rspec_matchers.send :define_method, :expect, real_expect
					end

					
					def supports_block_expectations?
						true
					end

					def matches? actual
						ap actual
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
