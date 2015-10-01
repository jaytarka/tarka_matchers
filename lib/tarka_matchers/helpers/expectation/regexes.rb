module TarkaMatchers
	module Helpers
		module Expectation
			module Regexes
				SGR = /\\e\[(?:10[0-7]|0{1,2}\d|0{0,1}\d\d|\d)m/
				NEWLINE = /\\n/
			end
		end
	end
end
