require 'tarka_matchers/helpers/string/sgr/styled_capture'
module TarkaMatchers
	module Matchers
		module Regex
			def match_sections *expected
				MatchSections.new expected
			end

			class MatchSections
				attr_reader :failure_message,:description
				def initialize expected
					@expected = expected
				end
				
				def when_used_on string
					@string = string
					self
				end

				def matches? actual
					@actual = actual
					pass_with_message
					fail_with_message

					integers = @expected.all?{ |v| v.is_a?(Integer) } 
					strings = @expected.all?{ |v| v.is_a?(String) } 
					
					if integers || strings
						@matches = indexes = Helpers::SGR::StyledCapture.indexes_of(@string, @actual)
						if indexes.empty?
							fail_with_message
						else
							if strings
								extracts = @matches.map{ |v| v[1] }.flatten
								pass_with_message
							else
								indexes = @matches.map{ |v| [v[0], v[2]] }.flatten
								if @expected.count.odd?
									fail_with_message "The indexes provided, '#{@expected}', are of an odd number. Please provide the start and end index pairs of all sections of '#{@string}' that should be selected by '#{@actual}'."
								elsif @expected.count < indexes.count
									fail_with_message "The index pairs provided, '#{@expected}', are less than the number of matches found in the string. Please provide the start and end index pairs of all sections of '#{@string}' that should be selected by '#{@actual}'."
								elsif @expected.count > indexes.count
									fail_with_message "The index pairs provided, '#{@expected}', are more than the number of matches found in the string. Please provide the start and end index pairs of all sections of '#{@string}' that should be selected by '#{@actual}'."
								elsif @expected == indexes
									pass_with_message
								end
							end
						end
					else
						fail_with_message "Provided a wrongly formatted argument to 'match_sections'. 'match_sections' expects an argument sequence consisting exclusively of either the start and end indexes of all expected sections of the provided string selected by the match, or an example of the actual text that is selected."	
					end
				end

				def pass_with_message message="contain the pattern, '#{@actual}' at positions #{indexes_list}." 
					@description = message
					true
				end	

				def fail_with_message message="The string, '#{@string}', does not contain the pattern, '#{@actual}'."
					@failure_message = message
					false
				end

				def report
					"\nThe regex matched:\n#{@string}\n"
				end

				def indexes_list
					list = ''
					li = @expected.length
					@expected.each_with_index do |v,i|
						if i.even?
							divider = ' to '
						elsif i == li - 3
							divider = ' and '
						elsif i != li - 1
							divider = ','
						end
						list << "'#{v}'#{divider}"
					end
					list
				end
			end
		end
	end
end
