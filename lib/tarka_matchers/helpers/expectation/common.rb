require 'tarka_matchers/helpers/expectation/regexes'
module TarkaMatchers
	module Helpers
		module Expectation
			module Common
				def keep_colors
					@keep_colors = true
					self
				end

				def keep_newlines
					@keep_newlines = true
					self
				end

				def clean! string
					string.gsub!(TarkaMatchers::Helpers::Expectation::Regexes::SGR,'') unless @keep_colors
					string.gsub!(TarkaMatchers::Helpers::Expectation::Regexes::NEWLINE,'') unless @keep_newlines
				end
			end
		end
	end
end
