require 'tarka_matchers/formatters/styles'
module TarkaMatchers
	module Formatters
		class Difference
			include Styles

			def self.difference expected, actual
				expected_line = "#{GREEN_F}Expected: #{BLACK_ON_GREEN}#{expected}#{RESET}"
				expected_length = expected.length
				actual_length = actual.length
				actual_line = "\n#{RESET}#{RED_F}  Actual: "

				longest = [expected,actual].sort_by(&:length).last 
				longest_length = longest.length
				expected = expected.split('')
				actual = actual.split('')
				correct = 0

				longest_length.times do |i|
					e = expected[i]
					a = actual[i]

					if expected_length <= i
						expected_line << "#{WHITE_BLOCK}"
						actual_line << "#{WHITE_ON_RED}#{a}"
					elsif actual_length <= i
						actual_line << "#{RED_BLOCK}"
					elsif e != a
						actual_line << "#{WHITE_ON_RED}#{a}"
					elsif e == a
						correct += 1
						actual_line << "#{BLACK_ON_GREEN}#{a}"
					end
				end

				identical = ((correct.to_f/longest_length) * 100).round 3
				"\n\n#{expected_line}#{actual_line}#{RESET}#{RED_F} - #{identical}% identical#{RESET}" 
			end	
		end
	end
end
