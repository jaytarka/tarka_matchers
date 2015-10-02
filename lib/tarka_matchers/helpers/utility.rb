module TarkaMatchers
	module Helpers
		module Utility
			attr_reader :description, :failure_message, :failure_message_when_negated

			def pass_default message
				@description = message
			end

			def fail_default option
				append, message = nil
				if option.is_a? Hash
					entry = option[0]
					case entry[0]
					when :append
						append = entry[1]
					when :just
						message = entry[1]
					end
				else
					message = option
				end

				@failure_message = message || "failed to #{@description}#{append}"
			end
	
			def negated_default message=nil
				@failure_message_when_negated = message || "did #{@description}"
			end

			def pass_with_message message=nil
				@description = message if message
				true
			end

			def fail_with_message message=nil
				@failure_message = message if message
				false
			end	

			alias_method :pass, :pass_with_message
			alias_method :fail, :fail_with_message
		end
	end
end
