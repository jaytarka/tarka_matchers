require 'spec_helper'
require 'tarka_matchers/helpers/rails/action_dispatch/route_populator'

route_populator = TarkaMatchers::Helpers::ActionDispatch::RoutePopulator
describe route_populator do
	Given(:lorem){ Faker::Lorem.word }
		
	describe '.route_populate' do
		context 'when both arguments are strings' do
			Then { expect{ route_populator.route_populate lorem, lorem }.to_not raise_error }
		end

		context 'when unpopulated_route contains no param-zones' do
			Given(:unpopulated_route){ '/foo/baz/bing' }
			Given(:populated_route){ '/foo/baz/bing'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }	
			Then { is_expected.to eq populated_route }
		end
			
		context 'when unpopulated_route contains param-zones' do
			Given(:unpopulated_route){ '/foo/:one/baz/:two/bing/:three' }
			Given(:populated_route){ '/foo/ARGUMENT1/baz/ARGUMENT2/bing/ARGUMENT3'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }	
			Then { is_expected.to eq populated_route }
		end	

		context 'when unpopulated route contains less params-zones than populated route' do
			Given(:unpopulated_route){ '/foo/:one/baz/:two/bing/:three' }
			Given(:populated_route){ '/foo/ARGUMENT1/baz/ARGUMENT2/bing/ARGUMENT3/boo/Argument4/boaah'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }		
			Then { is_expected.to_not eq populated_route }
			Then { is_expected.to eq "/foo/ARGUMENT1/baz/ARGUMENT2/bing/ARGUMENT3" }
		end	

		context 'when unpopulated route contains more param-zones than populated route' do
			Given(:unpopulated_route){ '/foo/:one/baz/:two/bing/:three/:four/:five/bing/boeey/boor/:six' }
			Given(:populated_route){ '/foo/ARGUMENT1/baz/ARGUMENT2/bing/ARGUMENT3'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }		
			Then { is_expected.to_not eq populated_route }
			Then { is_expected.to eq "/foo/ARGUMENT1/baz/ARGUMENT2/bing/ARGUMENT3/:four/:five/bing/boeey/boor/:six" }
			Then { expect{ subject }.to_not raise_error }
		end

		context 'when unpopulated route is of a totally different structure to populated route' do
			Given(:unpopulated_route){ '/foo/:one/baz/:two/bing/:three/hollla/:sixty/woahwoah/wee/3243' }
			Given(:populated_route){ '/foo/:one/:baz/ARGUMENT2/:bing/ARGUMENT3'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }		
			Then { is_expected.to_not eq populated_route }
			Then { expect{ subject }.to_not raise_error }
		end	

		context 'when unpopulated route resembles populated route but populated route has param-zones' do
			Given(:unpopulated_route){ '/foo/:one/baz/:two/bing/:three' }
			Given(:populated_route){ '/foo/ARGUMENT1/:baz/ARGUMENT2/:bing/ARGUMENT3'}
			subject{ route_populator.route_populate(unpopulated_route, populated_route) }		
			Then { is_expected.to_not eq populated_route }
			Then { is_expected.to eq '/foo/ARGUMENT1/baz/ARGUMENT2/bing/ARGUMENT3' }
			Then { expect{ subject }.to_not raise_error }
		end	
	end
end
