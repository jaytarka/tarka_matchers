module TarkaMatchers
	module Matchers
		module ActionDispatch
			def be_named_as expected
				BeNamedAs.new expected
			end

			class BeNamedAs
				def initialize expected
					@expected = expected
				end

				def description
				"be named as #{@expected}"
				end
				end
		end
	end
end
