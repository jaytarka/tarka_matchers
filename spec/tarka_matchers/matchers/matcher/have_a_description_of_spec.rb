require 'spec_helper'
require 'tarka_matchers/matchers/matcher/have_a_description_of'
require 'tarka_matchers/fixtures/foo_up_to'
require 'tarka_matchers/fixtures/baz_up_to'

describe TarkaMatchers::Matchers::Matcher do
	it{ is_expected.to respond_to :have_a_description_of }

	describe '.have_a_description_of' do
		context 'when target_matcher is foo_up_to' do
			subject{ expect{ expect(9833).to foo_up_to 458 }.to have_a_description_of description } 

			context 'when description is completely wrong' do
				let(:description){ 'whwhhwhwhw' }
				specify{ expect{ subject }.to fail }
			end
			context 'when description is correct but not prepended' do
				let(:description){ 'faz around.' }
				specify{ expect{ subject }.to fail }
			end
			context 'when description is correct' do
				let(:description){ 'should faz around.' }
				specify{ expect{ subject }.to pass }
			end
		end

		context 'when target_matcher is baz_up_to' do
			subject{ expect{ expect(9833).to baz_up_to 458 }.to have_a_description_of description } 

			context 'when description is completely wrong' do
				let(:description){ 'whwhhwhwhsfszxw' }
				specify{ expect{ subject }.to fail }
			end
			context 'when description is correct but not prepended' do
				let(:description){ 'baz around.' }
				specify{ expect{ subject }.to fail }
			end
			context 'when description is correct' do
				let(:description){ 'should baz around.' }
				specify{ expect{ subject }.to pass }
			end
		end
	end
end
