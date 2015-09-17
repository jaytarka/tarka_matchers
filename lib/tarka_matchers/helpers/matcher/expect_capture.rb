module TarkaMatchers
	module Helpers
		module Matcher
			class ExpectCapture
				def initialize target, block_target, active_matcher
					@active_matcher = active_matcher
					if target.length > 0
					else
						block_target.call
					end
				end

				def to matcher
					@active_matcher.actual_matcher = matcher
				end

				alias_method :to_not, :to
			end
		end
	end
end
