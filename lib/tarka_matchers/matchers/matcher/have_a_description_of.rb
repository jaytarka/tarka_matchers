require 'tarka_matchers/helpers/matcher/main'
#require 'tarka_matchers/helpers/matcher/expect_capture'
require 'awesome_print'

module TarkaMatchers
	module Matchers
		module Matcher
			class MatcherTarget
				def target target, block_target, active_matcher
					ap active_matcher
					@active_matcher = active_matcher
					if target.length > 0
					 ap target
					else
						block_target.call
					end
					self
				end

				def to matcher
					@matcher = matcher.description
					#@active_matcher.active_matcher @active_matcher
				end

				alias_method :to_not, :to
				end

				def	have_a_description_of expected			
					HaveADescriptionOf.new expected
				end

				class HaveADescriptionOf
			#		attr_writer :matcher
					def active_matcher the_matcher
						ap the_matcher
					end

					def initialize expected

					end

					
					def supports_block_expectations?
						true
					end

					def matches? actual
						ap 'here:'
						active_matcher = self
						rspec_matchers = ::RSpec::Matchers
						real_expect = rspec_matchers.instance_method :expect
						rspec_matchers.send :remove_method, :expect
						rspec_matchers.send(:define_method, :expect){ |*target, &block_target| MatcherTarget.new.target target, block_target, active_matcher }

						actual.call

						rspec_matchers.send :remove_method, :expect
						rspec_matchers.send(:define_method, :expect, real_expect)

					#	ap matcher
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
