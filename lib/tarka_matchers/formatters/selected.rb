require 'tarka_matchers/formatters/styles'
module TarkaMatchers
	module Formatters
		class Selected
			include Styles
			def self.selected original, selected
				ap original
				ap selected

				indexes = []
				selected.each_slice(2){ |si,ei| indexes << (si..ei).to_a }
				indexes.flatten!

				original_line = "#{GREEN_F}Original: #{BLACK_ON_GREEN}#{original}#{RESET}"
				selected_line = "\n#{RESET}#{RED_F}Selected: "
				
				selects = 0
				original.split('').each_with_index do |v,i|
					if indexes.include? i
						selects += 1
						selected_line << "#{BLACK_ON_GREEN}#{v}"
					else
						selected_line << "#{RED_BLOCK}"
					end
				end

				matched = ((selects.to_f/original.length) * 100).round 3
				"\n\n#{original_line}#{selected_line}#{RESET}#{RED_F} - #{matched}% matched#{RESET}\n " 
			end
		end
	end
end
