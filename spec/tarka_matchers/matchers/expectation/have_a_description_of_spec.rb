require 'spec_helper'
require 'tarka_matchers/matchers/expectation/have_a_description_of'
require 'tarka_matchers/matchers/expectation/support_block_expectations'
require 'tarka_matchers/fixtures/foo_up_to'
require 'tarka_matchers/fixtures/baz_up_to'

describe TarkaMatchers::Matchers::Expectation do
	it{ is_expected.to respond_to :have_a_description_of }

	describe '.have_a_description_of' do
		context 'when target_matcher is foo_up_to' do
			context 'when expectation is normal' do
				subject{ expect{ expect(9833).to foo_up_to 458 }.to have_a_description_of(description) } 

				context 'when description is completely wrong' do
					let(:description){ 'whwhhwhwhw' }
					specify{ expect{ subject }.to fail }
				end
				context 'when description is correct but not prepended' do
					let(:description){ "faz around. Actual: '9833', Expected: '458'"}
					specify{ expect{ subject }.to fail }
				end
				context 'when description is correct' do
					let(:description){ "should faz around. Actual: '9833', Expected: '458'"}
					specify{ expect{ subject }.to pass }
				end
			end
			context 'when expectation is negated' do
				subject{ expect{ expect(9833).to_not foo_up_to 458 }.to have_a_description_of(description) } 

				context 'when description is completely wrong' do
					let(:description){ 'whwhhwhwhw' }
					specify{ expect{ subject }.to fail }
				end
				context 'when description is correct but not prepended' do
					let(:description){ "faz around. Actual: '9833', Expected: '458'"}
					specify{ expect{ subject }.to fail }
				end
				context 'when description is correct' do
					let(:description){ "should not faz around. Actual: '9833', Expected: '458'"}
					specify{ expect{ subject }.to pass }
				end
			end
		end

		context 'when target_matcher is baz_up_to' do
			context 'when expectation is normal' do
				subject{ expect{ expect{ 98 + 33 }.to baz_up_to 458 }.to have_a_description_of(description) } 

				context 'when description is completely wrong' do
					let(:description){ 'whwhhwhwhsfszxw' }
					specify{ expect{ subject }.to fail }
				end
				context 'when description is correct but not prepended' do
					let(:description){ "baz around. Actual: '131', Expected: '458'"  }
					specify{ expect{ subject }.to fail }
				end
				context 'when description is correct' do
					let(:description){ "should baz around. Actual: '131', Expected: '458'" }
					specify{ expect{ subject }.to pass }
				end
			end

			context 'when expectation is negated' do
				subject{ expect{ expect{ 98 + 33 }.to_not baz_up_to 458 }.to have_a_description_of(description) } 

				context 'when description is completely wrong' do
					let(:description){ 'whwhhwhwhsfszxw' }
					specify{ expect{ subject }.to fail }
				end
				context 'when description is correct but not prepended' do
					let(:description){ "baz around. Actual: '131', Expected: '458'"  }
					specify{ expect{ subject }.to fail }
				end
				context 'when description is correct' do
					let(:description){ "should not baz around. Actual: '131', Expected: '458'" }
					specify{ expect{ subject }.to pass }
				end
			end
		end
	end
end
