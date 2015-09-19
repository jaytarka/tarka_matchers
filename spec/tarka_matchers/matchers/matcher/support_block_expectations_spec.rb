require 'spec_helper'
require 'tarka_matchers/matchers/matcher/support_block_expectations'
require 'tarka_matchers/matchers/matcher/have_a_description_of'
require 'tarka_matchers/fixtures/foo_up_to'
require 'tarka_matchers/fixtures/baz_up_to'
require 'tarka_matchers/fixtures/rawrg_up_to'

#					"utilize a matcher, #{@actual_matcher.class}, that supports block expectations."
describe TarkaMatchers::Matchers::Matcher do
	it{ is_expected.to respond_to :support_block_expectations }

	describe '.have_a_description_of' do
		context 'when target_matcher accepts block expectations' do
			subject{ expect{ expect{ 9833 }.to baz_up_to 458 }.to support_block_expectations } 
			specify{ expect{ subject }.to pass }
		end

		context 'when target_matcher explicitly does not accept block expectations' do
			subject{ expect{ expect( 3 + 9833 ).to foo_up_to 458 }.to support_block_expectations } 
			specify{ expect{ subject }.to fail }
		end

		context 'when target_matcher does not explicitly explicitly block expectations' do
			subject{ expect{ expect( 3 + 9833 ).to rawrg_up_to 458 }.to support_block_expectations } 
			specify{ expect{ subject }.to fail }
		end
	end
end
