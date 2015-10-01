require 'the_great_escape'
module TarkaMatchers
	module Helpers
		module SGR
			class StyledCapture
				STYLED = /\\e\[\d{1,3}m\K(?!\\e\[\d{1,3}m)(.+?)(?=\\e\[\d{1,3}m|$)/
				CODE = /\\e\[\K\d{1,3}(?=m)/
				
				def self.indexes_of string, regex
					string.to_enum(:scan,regex).map do |v,|
						si = $`.size
						[si, v, si + v.length - 1]
					end
				end

				def self.capture string, number
					#[]
					#puts string
					string = escape(string)
					#puts '##################################'
					puts self.indexes_of( string, /ab/)
					#puts '##################################'
					#.scan(CODE).uniq
				end
			end
		end
	end
end
