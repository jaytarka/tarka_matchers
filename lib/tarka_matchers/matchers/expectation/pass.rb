require 'tarka_matchers/helpers/expectation/result'
module TarkaMatchers
	module Matchers
		module Expectation
			def	pass
				Pass.new
			end

			class Pass
				def supports_block_expectations?; true; end

				def matches? expectation
					@actual = TarkaMatchers::Helpers::Expectation::Result.pass?{ expectation.call }
					@actual == true
				end

				def description	
					"pass."
				end
			
				def report
					"Spec result: #{@actual}"
				end

				def failure_message
					"#{description} #{report}"
				end

				def failure_message_when_negated
					"#{description} #{report}"
				end
			end
		end
	end
end
