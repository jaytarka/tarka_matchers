module TarkaMatchers
	module Helpers
		module ActionDispatch
			class RoutePopulator
				def self.route_populate unpopulated_route, populated_route
   				converted_route = unpopulated_route.dup	
    			converted_route.gsub!('(.:format)','')

					if populated_route != converted_route
						syncronizer = 0 
						unpopulated_route.scan /(?<=\/):\w+/ do |m|
							start_index = $~.offset(0)[0] + syncronizer
							break if start_index > populated_route.length
							end_index = $~.offset(0)[1] + syncronizer
      				named_length = end_index - start_index
      				parameter = populated_route.match(/(?<=\/)\w+/, start_index).to_s
      				syncronizer += (named_length - parameter.length).abs
      				converted_route.slice! start_index..end_index-1
							converted_route.insert start_index, parameter
						end
 					end
	
					converted_route	
				end
			end
		end
	end
end
