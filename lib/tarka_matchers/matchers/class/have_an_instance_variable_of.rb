require 'tarka_matchers/helpers/expectation/result'
require 'tarka_matchers/helpers/utility'
require 'tarka_matchers/formatters/difference'
module TarkaMatchers
	module Matchers
		module Class
			def	have_an_instance_variable_of instance_name
				HaveAnInstanceVariableOf.new instance_name
			end

			class HaveAnInstanceVariableOf
				include TarkaMatchers::Helpers::Utility
				def initialize instance_name
					@instance_name = instance_name
				end

				def that_equals expected
					@expected = expected
					self
				end
				
				def matches? actual
					@actual = actual.instance_variable_get(@instance_name)
					fail_with_message "failed to contain an instance variable called '#{@instance_name}'. It does not exist inside the class." unless actual.instance_variable_defined?(@instance_name)
					pass_default "contain an instance variable called, '#{@instance_name}', that equals '#{@expected}'."
					negated_default
					#fail_default "failed to #{description}\n#{TarkaMatchers::Formatters::Difference.difference(@expected,@actual)}"
					@actual == @expected
				end

#				def description
#				end

#				def failure_message
#				end

#				def failure_message_when_negated
#					"did #{description}"
#				end
			end
		end
	end
end
