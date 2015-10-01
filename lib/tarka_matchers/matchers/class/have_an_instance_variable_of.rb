require 'tarka_matchers/helpers/expectation/result'
require 'tarka_matchers/formatters/difference'
module TarkaMatchers
	module Matchers
		module Class
			def	have_an_instance_variable_of instance_name
				HaveAnInstanceVariableOf.new instance_name
			end

			class HaveAnInstanceVariableOf
				def initialize instance_name
					@instance_name = instance_name
				end

				def that_equals expected
					@expected = expected
					self
				end
				
				def matches? actual
#					fail_with "failed to contain an instance variable called '@blarsey'. It does not exist inside the class." unless actual.instance_variable_defined?(@instance_name)
					@actual = actual.instance_variable_get(@instance_name)
					@actual == @expected
				end

				def description
					"contain an instance variable called, '#{@instance_name}', that equals '#{@expected}'."
				end

				def failure_message
					"failed to #{description}\n#{TarkaMatchers::Formatters::Difference.difference(@expected,@actual)}"
				end

				def failure_message_when_negated
					"did #{description}"
				end
			end
		end
	end
end
