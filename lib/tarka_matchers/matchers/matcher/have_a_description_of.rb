require 'tarka_matchers/helpers/matcher/main'
require 'tarka_matchers/helpers/matcher/expect_capture'

module TarkaMatchers
	module Matchers
		module Matcher
				def	have_a_description_of expected
					HaveADescriptionOf.new expected
				end

				class HaveADescriptionOf
					def initialize expected
						@expected = expected
						matcher_target = TarkaMatchers::Helpers::Matcher::ExpectCapture
						puts "Heres the two folks: #{matcher.to}"
					end

					
					def supports_block_expectations?
						true
					end

					def matches? actual
						puts actual
						actual.call

						#matcher = actual.call
#						matcher.send :matches?,
						#puts 
						#puts @expected
						
						#@actual = matcher.description
						#if @actual
						#	false
						#else
					#		@actual
					#	end
					end

					def description	
						"fail."
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
