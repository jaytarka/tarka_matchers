module TarkaMatchers
	module Helpers
		module Matcher
			class ExpectCapture
				def initialize target, block_target
					if target.length > 0
					else
						block_target.call
					end
				end

				class <<self
					attr_writer :actual_matcher
				end

				def self.capture actual
					rspec_matchers = ::RSpec::Matchers
					expect_capture = self
					real_expect = rspec_matchers.instance_method :expect
					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect){ |*target, &block_target| expect_capture.new(target, block_target) }

					actual.call
					ap real_expect
					rspec_matchers.send :remove_method, :expect
					rspec_matchers.send(:define_method, :expect, real_expect)
					
					@actual_matcher
				end

				def to matcher
					self.class.actual_matcher = matcher
				end

				alias_method :to_not, :to
				
				private
					def self.swap &method
						
					end
			end
		end
	end
end
