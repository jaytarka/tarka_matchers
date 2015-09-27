require 'tarka_matchers/formatters/styles'
require 'stringio'
module TarkaMatchers
	module Commands
		module Install
			include TarkaMatchers::Formatters::Styles
			FILE_NAME = /(?:[^\/])+(?=\.txt$)/
			def self.install flags
				path = 'lib/tarka_matchers/helpers/string/sgr/sgr_sequences'
				detected_terminal = ENV['TERM']
				specified_terminal = flags.index('-i')
				specified_terminal ? terminal = flags[specified_terminal+1] : terminal = detected_terminal
				
				begin
					sequence = ''
					sequence_array = IO.read("#{path}/#{terminal}.txt").split("\n")
					sequence_array_length = sequence_array.length
					sequence_array.each_with_index do |v,i| 
						string = "\n\t\t\t:#{v}, #\\e[#{i}m"
						case i
						when 0
							sequence << "[#{string}"
						when sequence_array_length - 1
							sequence << "#{string}\n\t\t]"
						else
							sequence << string
						end
					end
				rescue Errno::ENOENT
					puts "#{RED_F}TarkaMatchers doesn't currently contain a configuration file for a #{YELLOW_F}#{terminal}#{RED_F} interface. Here are the currently available interface configurations:#{YELLOW_F}"
					Dir["#{path}/*.txt"].each_with_index{ |v,i| puts FILE_NAME.match(v).to_s.prepend("#{i+1}) ") }
					puts "#{RED_F}This should only be a concern if you plan on using our SGR matchers, (e.g. 'be_red' or 'be_bold'), and even then, most modern interfaces are configured very similarly to #{YELLOW_F}xterm#{RED_F}. Consider adding a confguration file for your terminal, #{YELLOW_F}#{terminal}#{RED_F}, to the TarkaMatchers github repository.#{RESET}"
					terminal = 'xterm'					
				end
				puts sequence	
				config = File.new 'tarka_matchers.config.rb', 'w'
				config.write "module TarkaMatchers\n\tmodule Config\n\t\tSGR_CODES = #{sequence}\n\t\tend\n\tend"
				config.close
					puts "Created config file in gem root: #{GREEN_F}#{Dir.pwd}/#{L_GREEN_F}tarka_matchers_config.rb#{RESET} with #{YELLOW_F}#{terminal}#{RESET} SGR settings applied.\nIf when using our SGR matchers, (e.g. 'be_red' or 'be_bold'), you find your SGR expectations are behaving strangely, edit the #{YELLOW_F}TarkaMatchers::Config::SGR_CODES#{RESET} array, found in #{L_GREEN_F}tarka_matchers_config.rb#{RESET}. For more information into SGR codes visit: 'https://en.wikipedia.org/wiki/ANSI_escape_code'."
			end

			private
				def self.sequence_file

				end

				def self.create_config
				end
		end
	end
end
