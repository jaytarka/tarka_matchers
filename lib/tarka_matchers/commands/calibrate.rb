module TarkaMatchers
	module Commands
		def self.calibrate
			lib = File.expand_path('../../../..', __FILE__)
			$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
			require 'tarka_matchers.config.rb'
			require 'io/console'
			require 'terminfo'
			include TarkaMatchers::Config
			puts "Beginning SGR calibration test..."
			all_sgr =  [['aaa',0],['aab',0]]  #SGR_CODES.map{ |v| [v,0] }
			SGR_CODES.each_with_index do |v,i|
				pangram = "The quick brown fox jumps over the lazy dog"
				spaces = '' 
				(i.to_s.length - 1).times{ spaces << ' ' }
				puts "Currently testing SGR code: #{i}\n          Escaped sequence: \\e[#{i}m\n\nDefault Text, reset with \\e[0m#{spaces}: #{pangram}\nStyled Text, styled with \\e[#{i}m: \e[#{i}m#{pangram}\e[0m\n\nThe styled text should look #{v}."
			array = ['2222','333221','3322']
			inputs = []
			closest = [-1, 0]
			puts 100
			while input = STDIN.raw(&:getch)
				if input == "\r"
					break
				else
					if input == "\u007F"
						inputs.pop
					else
						inputs << input
					end
#					puts inputs.inspect	
#					all_sgr.map! do |v|
#						[v[0], (v[0].split('') & inputs).length]
#					end
#					all_sgr.sort_by!{ |v| !v[1] }		
					print "\r                                                                                                                                                                                       \r"
					STDOUT.flush
					print "\r#{inputs.join}\r\n\rHello\r"
					i -= 1
				end
			end
			break
			SGR_CODES

=begin
require 'time'

loop do
  time = Time.now.to_s + "\r"
  print time
  $stdout.flush
  sleep 1
end
=end
			end
		end
	end
end
