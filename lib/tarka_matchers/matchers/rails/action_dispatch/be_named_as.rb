#module TarkaMatchers
#	module Matchers
#		module Rails
#			module ActionDispatchz
#				def yun
#					puts 'hello'
#				end
#
#				def be_named_as expected
#					BeNamedAs.new expected
#				end
#
#				class BeNamedAs
#					def initialize expected
#						@expected = expected
#					end
#
#					def description
#						"be named as #{@expected}"
#					end
#				end
#			end
#		end
#	end
#end
#

module ActionDispatch
	def zupp
		puts 'rawr im tazzy!'
	end
end
