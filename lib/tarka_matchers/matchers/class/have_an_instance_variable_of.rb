require 'tarka_matchers/helpers/expectation/result'
module TarkaMatchers
	module Matchers
		module Class
			def	have_an_instance_variable_of instance_name
				HaveAnInstaceVariableOf.new instance_name
			end

			class HaveAnInstanceVariableOf
				def initialize instance_name
					@instance_name = instance_name
				end

				def that_equals expected
					@expected = expected
				end
				
				def matches? actual
					@actual = actual.instance_variable_get(@instance_name)
					@actual == @expected
				end

				def description
					"contain an instance variable called, '#{@instance_name}', that equals '#{@actual}'."
				end

				def failure_message
					"failed to #{description}"
				end

				def failure_message_when_negated
					description
				end
			end
		end
	end
end
