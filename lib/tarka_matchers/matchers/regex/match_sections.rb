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
						if indexes.empty?
							false
						else
							if strings
								true
							else
								if @expected.count.odd?
									@odd = true
									false
								elsif @expected == indexes.map{ |v| [v[0], v[2]] }.flatten
									true
								end
							end
						end
					else
						@unpure = true
						false
					end
				end
				
				def description
					"contain the pattern, '#{@actual}' at positions #{indexes_list}" 
				end

				def failure_message
					if @unpure
 						"Provided a wrongly formatted argument to 'match_sections'. 'match_sections' expects an argument sequence consisting exclusively of either the start and end indexes of all expected sections of the provided string selected by the match, or an example of the actual text that is selected."
					elsif @odd
						"The indexes provided, '#{@expected}', are of an odd number. Please provide the start and end index pairs of all sections of '#{@string}' that should be selected by '#{@actual}'."
					else
						"The string, '#{@string}', does not contain the pattern, '#{@actual}'."
					end
				end

					def indexes_list
						list = ''
						li = @expected.length
						@expected.each_with_index do |v,i|
							if i.even?
								divider = ' to '
							else
								case i
								when li - 3
									divider = ' and '
								when li - 1
									divider = ''
								else
									divider = ','
								end
							end
							list << "'#{v}'#{divider}"
						end
						list
					end
			end
		end
	end
end
