module TarkaMatchers
	module Formatters
		class Difference
			def self.difference expected, actual
				expected_line = "\e[32mExpected: #{green}#{expected}#{reset}"
				expected_length = expected.length
				actual_length = actual.length
				actual_line = "\n\e[31m  Actual: "

				longest = [expected,actual].sort_by(&:length).last 
				longest_length = longest.length
				expected = expected.split('')
				actual = actual.split('')
				incorrect = 0

				longest_length.times do |i|
					e = expected[i]
					a = actual[i]

					if expected_length <= i
						expected_line << "#{white_block}"
						actual_line << "#{red}#{a}"
					elsif actual_length <= i
						actual_line << "#{red_block}"
					elsif e != a
						actual_line << "#{red}#{a}#{reset}"
					elsif e == a
						incorrect += 1
						actual_line << "#{green}#{a}#{reset}"
					end
				end
				correct = ((expected_length - incorrect)/(expected_length)) * 100
				"#{expected_line}#{actual_line}#{reset}\e[31m - #{correct}% identical#{reset}" 
			end
			
			def self.reset
				"\e[0m"
			end

			def self.red
				"\e[41m\e[37m"
			end
			
			def self.white_block
				"\e[47m\e[37mX#{reset}"
			end
		
			def self.red_block
				"\e[41m\e[31mX#{reset}"
			end

			def self.green
				"\e[42m\e[30m"
			end
		end
	end
end
