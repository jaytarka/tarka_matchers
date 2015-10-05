require 'tarka_matchers/formatters'
module TarkaMatchers
	module Helpers
		module Utility
			attr_reader :description, :failure_message, :failure_message_when_negated
			
			def difference
				" #{TarkaMatchers::Formatters::Difference.difference(@expected,@actual)}"
			end

			def selected
				" #{TarkaMatchers::Formatters::Selected.selected(@expected,@actual)}"
			end

			def pass_default message='pass'
				@description = message
				negated_default
				fail_default
			end

			def negated_default message=nil
				@failure_message_when_negated = message || "did #{@description}"
			end

			def fail_default option=nil
				append, message = nil

				if option == nil
					append = difference
				elsif option.is_a? String
					message = option
				elsif option.is_a? Hash
					k = option.first[0]
					v = option.first[1]
					case k
					when :append
						if v.is_a? String
							append = v
						elsif v.is_a? Symbol
							case v
							when :difference
								append = difference
							when :selected
								append = selected
							end
						else
							append = difference
						end
					when :just
						message = v
					end
				end

				@failure_message = message || "failed to #{@description}#{append}"
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
