require 'tarka_matchers/helpers/string/sgr/styled_capture'
require 'tarka_matchers/helpers/utility'
require 'tarka_matchers/formatters/selected'
module TarkaMatchers
	module Matchers
		module Regex
			def match_sections *expected
				MatchSections.new expected
			end

			class MatchSections
				include TarkaMatchers::Helpers::Utility
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
						@matches = indexes = Helpers::SGR::StyledCapture.indexes_of(@string, @actual)

						# indexes_and_content
						# indexes
						# content
						pass_default "contain the pattern, '#{@actual}' at positions #{indexes_list}." 
						fail_default "The string, '#{@string}', does not contain the pattern, '#{@actual}':#{selected(@string, @matches.map{ |v| [v[0], v[2]] }.flatten)}"

						if indexes.empty?
							fail_with_message
						else
							if strings
								extracts = @matches.map{ |v| v[1] }.flatten
								if @expected == extracts
									pass_with_message "contain the pattern, '#{@actual}' and match: #{extracts_list}."
								else
									fail
								end
							else
								indexes = @matches.map{ |v| [v[0], v[2]] }.flatten
								if @expected.count.odd?
									fail_with_message "The indexes provided, '#{@expected}', are of an odd number. Please provide the start and end index pairs of all sections of '#{@string}' that should be selected by '#{@actual}'."
								elsif @expected.count < indexes.count
									fail_with_message "The index pairs provided, '#{@expected}', are less than the number of matches found in the string. Please provide the start and end index pairs of all sections of '#{@string}' that should be selected by '#{@actual}'."
								elsif @expected.count > indexes.count
									fail_with_message "The index pairs provided, '#{@expected}', are more than the number of matches found in the string. Please provide the start and end index pairs of all sections of '#{@string}' that should be selected by '#{@actual}'."
								else
									@expected == indexes
								end
							end
						end
					else
						fail_with_message "Provided a wrongly formatted argument to 'match_sections'. 'match_sections' expects an argument sequence consisting exclusively of either the start and end indexes of all expected sections of the provided string selected by the match, or an example of the actual text that is selected."	
					end
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

				def extracts_list
					list = ''
					li = @expected.length
					@expected.each_with_index do |v,i|
						if i == li - 2
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
