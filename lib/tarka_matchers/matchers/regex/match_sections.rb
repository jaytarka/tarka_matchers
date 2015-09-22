require 'tarka_matchers/helpers/string/sgr/styled_capture'
module TarkaMatchers
	module Matchers
		module Regex
			def match_sections *expected
				MatchSections.new expected
			end

			class MatchSections
				def initialize expected
					@expected = expected
				end
				
				def when_used_on string
					@string = string
					self
				end

				def matches? actual
					@actual = actual
					integers = @expected.all?{ |v| v.is_a?(Integer) } 
					strings = @expected.all?{ |v| v.is_a?(String) } 
					
					if integers || strings
						indexes = Helpers::SGR::StyledCapture.indexes_of @string, @actual
						if strings
							if indexes.empty?
								false
							else
								true
							end
						else
							if indexes.empty?
								false
							else
								true
							end
						end
					else
						@unpure = true
						false
					end
				end
				
				def failure_message
					if @unpure
 						"Provided a wrongly formatted argument to 'match_sections'. 'match_sections' expects an argument sequence consisting exclusively of either the start and end indexes of all expected sections of the provided string selected by the match, or an example of the actual text that is selected."
					else
						"The string, '#{@string}', does not contain the pattern, '#{@actual}'."
					end
				end
			end
		end
	end
end
