module TarkaMatchers
	module Helpers
		module Matcher
			class Main
				def self.pass? &b
					error = true
					begin
						b.call
					rescue RSpec::Expectations::ExpectationNotMetError => error
					end
					error
				end
			end
		end
	end
end
