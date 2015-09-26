require 'tarka_matchers/formatters/styles'
require 'stringio'
module TarkaMatchers
	module Commands
		module Install
			include TarkaMatchers::Formatters::Styles
			def self.install
				terminal = ENV['TERM']
				puts "Created config file in gem root: #{GREEN_F}#{Dir.pwd}/#{L_GREEN_F}tarka_matchers_config.rb#{RESET} with #{YELLOW_F}#{terminal}#{RESET} SGR settings applied.\nIf when using our SGR matchers, (e.g. 'be_red' or 'be_bold'), you find your SGR expectations are behaving strangely, edit the #{YELLOW_F}TarkaMatchers::Config::SGR_CODES#{RESET} array, found in #{L_GREEN_F}tarka_matchers_config.rb#{RESET}. For more information into SGR codes visit: 'https://en.wikipedia.org/wiki/ANSI_escape_code'."
			end
		end
	end
end
