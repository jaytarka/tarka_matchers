module TarkaMatchers
	module Helpers
		module Expectation
			module Common
				SGR = /\\e\[(?:10[0-7]|0{1,2}\d|0{0,1}\d\d|\d)m/
				NEWLINE = /\\n/
				def keep_sgrs
					@keep_sgrs = true
					self
				end

				def keep_newlines
					@keep_newlines = true
					self
				end

				def clean! string
					string.gsub!(SGR,'') unless @keep_sgrs
					string.gsub!(NEWLINE,'') unless @keep_newlines
					string
				end
			end
		end
	end
end
