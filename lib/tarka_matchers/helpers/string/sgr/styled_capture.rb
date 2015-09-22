require 'the_great_escape'
module TarkaMatchers
	module Helpers
		module SGR
			class StyledCapture
				SGR = /\\e\[\d{1,3}m/
				STYLED = /\\e\[\d{1,3}m\K(?!\\e\[\d{1,3}m)(.+?)(?=\\e\[\d{1,3}m|$)/
				CODE = /\\e\[\K\d{1,3}(?=m)/
				
				def self.indexes_of string, regex
					string.to_enum(:scan,regex).map{ |m,| [$`.size, m, $~.begin(0)] }
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
