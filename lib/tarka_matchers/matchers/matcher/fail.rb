#require 'active_support/inflector'
#require 'sourcify'
def pass
	def supports_block_expectations?; true; end
	Pass.new
end

def fail
	def supports_block_expectations?; true; end
	Pass.new false
end

class Pass
	def initialize pass=true
		@pass = pass
		@pass ? @type = 'pass' : @type = 'fail'
	end

	def matches? expectation
		puts expectation.source_location
		expectation.to_source(:attached_to => :proc)
		begin
			expectation.call
		rescue RSpec::Expectations::ExpectationNotMetError => @e
			@pass = !@pass
		end
		@pass
	end

	def generic_message
		operator = ''
		report = ''
		report << "The spec's failure is: #{@e}" if @type == 'fail'
		case caller_locations.first.label
		when 'failure_message'
			operator = 'did not '
		when 'failure_message_when_negated'
			operator = 'did not '
		when 'description'
			report = ''
		end
		"#{operator}#{@type}. #{report}"	
	end

	def description	
		generic_message
	end

	def failure_message
		generic_message
	end

	def failure_message_when_negated
		generic_message
	end
end
