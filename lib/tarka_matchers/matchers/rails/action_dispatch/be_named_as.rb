module TarkaMatchers
	module Matchers
		module ActionDispatch
			class BeNamedAsMatcher
				def initialize route_name
					@route_name = route_name
				end

				def description
					"be named as #{@route_name}"
				end
			end
		end
	end
end
