module TarkaMatchers
	module Matchers
		module SGR
			def be_red
				BeNamedAs.new
			end

			class Red
				def description
				"be named as #{@expected}"
				end
			end
		end
	end
end
