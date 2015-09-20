require 'spec_helper'

describe TarkaMatchers::Matchers::Expectation do
	it{ is_expected.to respond_to :have_a_failure_message_when_negated_of }
	let(:expected){ 234234 }
	let(:actual){ 23234 }

	describe '.have_a_failure_message_when_negated_of' do
		context 'when target_matcher is foo_up_to' do
			subject{ expect{ expect(actual).to foo_up_to expected }.to have_a_failure_message_when_negated_of(failure_message_when_negated) } 
			context 'when failure_message_when_negated is completely wrong' do
				let(:failure_message_when_negated){ 'whwhhwhwhw' }
				specify{ expect{ subject }.to fail }
			end
			context 'when failure_message_when_negated is correct but not prepended' do
				let(:failure_message_when_negated){ "faz around. Expected #{expected}, got #{actual}." }
				specify{ expect{ subject }.to fail }
			end
			context 'when failure_message_when_negated is correct' do
				let(:failure_message_when_negated){ "fiz around. Expected #{expected}, got #{actual}." }
				specify{ expect{ subject }.to pass }
			end
		end

		context 'when target_matcher is baz_up_to' do
			subject{ expect{ expect(actual).to baz_up_to expected }.to have_a_failure_message_when_negated_of(failure_message_when_negated) } 

			context 'when failure_message_when_negated is completely wrong' do
				let(:failure_message_when_negated){ 'xxxxrt' }
				specify{ expect{ subject }.to fail }
			end
			context 'when failure_message_when_negated is correct but not prepended' do
				let(:failure_message_when_negated){ "baz around. Expected #{expected}, got #{actual}." }
				specify{ expect{ subject }.to fail }
			end
			context 'when failure_message_when_negated is correct' do
				let(:failure_message_when_negated){ "biz around. Expected #{expected}, got #{actual}." }
				specify{ expect{ subject }.to pass }
			end
		end
	end
end
