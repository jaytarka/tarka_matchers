module TarkaMatchers
	module Helpers
		module Matcher
			class ExpectCapture
				def initialize target, block_target
					target == :undefined ? @target = block_target.call : @target = target
				end
				
				def self.capture actual
					self.redefine
					actual.call
					self.replace
					@actual_matcher
				end

				class <<self
					attr_writer :actual_matcher
				end

				def to matcher
					match_populate 'should ', matcher
				end

				def to_not matcher
					match_populate 'should not ', matcher
				end

				private
					def match_populate verb, matcher
						matcher.send :matches?, @target
						self.class.actual_matcher = [verb,matcher]
					end

					def self.remove
						@rspec_matchers.send :remove_method, :expect
					end

					def self.redefine
						@rspec_matchers = ::RSpec::Matchers
						@real_expect = @rspec_matchers.instance_method :expect
						self.remove
						expect_capture = self
						@rspec_matchers.send(:define_method, :expect){ |target=:undefined, &block_target| expect_capture.new(target, block_target) }
					end

					def self.replace
						self.remove
						@rspec_matchers.send(:define_method, :expect, @real_expect)
					end
			end
		end
	end
end
