require 'tarka_matchers/formatters/styles'
module TarkaMatchers
	module Formatters
		class Selected
			include Styles
			def self.selected string, selected
				"Original:"
			end
		end
	end
end
