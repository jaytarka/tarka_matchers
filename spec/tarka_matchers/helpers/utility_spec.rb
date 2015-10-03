require 'spec_helper'
require 'tarka_matchers/utility'
describe TarkaMatchers::Helpers::Utility do
	let(:parent){ Class.new{ include( TarkaMatchers::Helpers::Utility ) }.new }
	subject{ parent }
	it{ is_expected.to respond_to :description }
	it{ is_expected.to respond_to :failure_message }
	it{ is_expected.to respond_to :pass_with_message }
	it{ is_expected.to respond_to :fail_with_message }
	it{ is_expected.to respond_to :pass }
	it{ is_expected.to respond_to :fail }
	it{ is_expected.to respond_to :pass_default }
	it{ is_expected.to respond_to :fail_default }
	it{ is_expected.to respond_to :negated_default }
	it{ is_expected.to respond_to :pass_with_message }
	it{ is_expected.to respond_to :fail_with_message }
	it{ is_expected.to respond_to :pass_with_message }
	
	describe '#description' do
		subject{ parent.description }
		context 'when pass_with_message' do
			before{ parent.pass_default }
			it{ is_expected.to eq 'pass' }
		end
	end

	describe '#failure_message' do
		subject{ parent.failure_message }
		context 'when pass_with_message' do
			before{ parent.pass_default }
			it{ is_expected.to include 'failed to pass' }
			it{ is_expected.to include '% identical' }
		end
	end

	describe '#failure_message_when_negated' do
		subject{ parent.failure_message_when_negated }
		context 'when pass_with_message' do
			before{ parent.pass_default }
			it{ is_expected.to eq 'did pass' }
		end
	end
end
