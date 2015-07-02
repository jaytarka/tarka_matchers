require 'spec_helper'
require 'tarka_matchers/helpers/action_dispatch/RoutePopulator'

route_populator = TarkaMatchers::Helpers::ActionDispatch::RoutePopulator
describe route_populator do
	Given(:lorem){ Faker::Lorem.word }
		
	describe '.route_populate' do
		context 'when both arguments are strings' do
			Then { expect{ route_populator.route_populate lorem, lorem }.to_not raise_error }
		end

		context 'when unpopulated_route contains no params' do
			Given(:unpopulated_route){ '/foo/baz/bing' }
			Given(:populated_route){ '/foo/baz/bing'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }	
			Then { is_expected.to eq populated_route }
		end
			
		context 'when unpopulated_route contains params' do
			Given(:unpopulated_route){ '/foo/:one/baz/:two/bing/:three' }
			Given(:populated_route){ '/foo/ARGUMENT1/baz/ARGUMENT2/bing/ARGUMENT3'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }	
			Then { is_expected.to eq populated_route }
		end	

		context 'when populated_route contains params' do
			Given(:unpopulated_route){ '/foo/:one/baz/:two/bing/:three' }
			Given(:populated_route){ '/foo/ARGUMENT1/b/:one/az/ARGUMENT2/bing/AR/:two/GUMENT3'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }	
			Then { is_expected.to eq populated_route }
		end	
	end
end
