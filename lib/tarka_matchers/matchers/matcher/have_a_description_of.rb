require 'tarka_matchers/helpers/matcher/main'
#require 'tarka_matchers/helpers/matcher/expect_capture'
require 'awesome_print'

module TarkaMatchers
	module Matchers
		module Matcher
			class MatcherTarget
				def target target, block_target
					puts 'called'
					if target
						ap target
					else
						ap block_target
						block_target.call
					end
					self
				end

				def to matcher
					puts "Matcher: #{matcher.inspect}"	
				end

				alias_method :to_not, :to
		end

				def	have_a_description_of expected			
					rspec_matchers = ::RSpec::Matchers
					real_expect = rspec_matchers.instance_method :expect
					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect){ |target=nil,&block_target| MatcherTarget.new.target target, block_target }
	
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
