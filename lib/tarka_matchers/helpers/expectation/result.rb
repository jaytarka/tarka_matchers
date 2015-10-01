module TarkaMatchers
	module Helpers
		module Expectation
			class Result
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
