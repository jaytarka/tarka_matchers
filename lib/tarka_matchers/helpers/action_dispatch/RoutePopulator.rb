module TarkaMatchers
	module Helpers
		module ActionDispatch
			class RoutePopulator
				def self.route_populate unpopulated_route, populated_route
   				converted_route = unpopulated_route.dup
   				
					syncronizer = 0 
					unpopulated_route.scan /(?<=\/):\w+/ do |m|
						start_index = $~.offset(0)[0] + syncronizer
						end_index = $~.offset(0)[1] + syncronizer
      			named_length = end_index - start_index
      			parameter = populated_route.match(/(?<=\/)\w+/, start_index).to_s
      			syncronizer += (named_length - parameter.length).abs
      			converted_route.slice! start_index..end_index-1
						converted_route.insert start_index, parameter
					end
  
    			converted_route.gsub('(.:format)','')
				end
			end
		end
	end
end
