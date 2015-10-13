require 'tarka_matchers/formatters/styles'
module TarkaMatchers
	module Formatters
		class Selected
			include Styles
			def self.selected original, selected
				indexes, actual_boundaries = [], []
				selected.each_slice(2) do |si,ei| 
					indexes << (si..ei).to_a
					actual_boundaries  << [si,ei]
				end
				indexes.flatten!
				actual_boundaries.flatten!

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
				"\n\n#{original_line}#{selected_line}#{RESET}#{RED_F} - #{matched}% matched.\n#{RED_F}Bounds:   #{actual_boundaries}\n#{WHITE_F}Formatter: #{self.name}#{RESET}" 
			end
		end
	end
end
