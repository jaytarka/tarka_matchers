require 'spec_helper'

describe TarkaMatchers::Matchers::Expectation do
	it{ is_expected.to respond_to :have_a_failure_message_of }

	describe '.have_a_failure_message_of' do
		context 'when target_matcher is foo_up_to' do
			subject{ expect{ expect(9833).to foo_up_to 458 }.to have_a_failure_message_of(failure_message) } 

			context 'when description is completely wrong' do
				let(:failure_message){ 'whwhhwhwhw' }
				specify{ expect{ subject }.to fail }
			end
			context 'when description is correct but not prepended' do
				let(:failure_message){ "faz around. Actual: '9833', Expected: '458'"}
				specify{ expect{ subject }.to fail }
			end
			context 'when description is correct' do
				let(:failure_message){ "foo around. Expected 458, got 9833."}
				specify{ expect{ subject }.to pass }
			end
		end

		context 'when target_matcher is baz_up_to' do
			subject{ expect{ expect{ 98 + 33 }.to baz_up_to 458 }.to have_a_failure_message_of(failure_message) } 

			context 'when description is completely wrong' do
				let(:failure_message){ 'whwhhwhwhsfszxw' }
				specify{ expect{ subject }.to fail }
			end
			context 'when description is correct but not prepended' do
				let(:failure_message){ "baz around. Actual: '131', Expected: '458'"  }
				specify{ expect{ subject }.to fail }
			end
			context 'when description is correct' do
				let(:failure_message){ "boo around. Expected 458, got 131." }
				specify{ expect{ subject }.to pass }
			end
		end
	end
end
