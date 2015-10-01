module TarkaMatchers
	module Helpers
		module Utility
			attr_reader :failure_message, :description

			def pass_default message
				@pass_default = message
			end

			def fail_default message
				@fail_default = message
			end

			def pass_with_message message=nil
				@description = message || @pass_default
				true
			end

			def fail_with_message message=nil
				@failure_message = message || @fail_default
				false
			end

			alias_method :pass, :pass_with_message
			alias_method :fail, :fail_with_message
		end
	end
end
