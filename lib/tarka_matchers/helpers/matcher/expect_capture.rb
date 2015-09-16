module TarkaMatchers
	module Helpers
		module Matcher
			class ExpectCapture
				class MatcherTarget
					def initialize target
						puts target
					end

					def to matcher
						puts 'boooooooooooop'
						puts matcher.inspect	
					end

					alias_method :to_not, :to
				end

				rspec_matchers = ::RSpec::Matchers
				real_expect = rspec_matchers.instance_method :expect
				rspec_matchers.send :remove_method, :expect
				rspec_matchers.send(:define_method, :expect){ |target| MatcherTarget.new target }
			end
		end
	end
end

