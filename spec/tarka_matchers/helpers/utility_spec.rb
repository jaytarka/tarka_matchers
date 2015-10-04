require 'spec_helper'
require 'tarka_matchers/utility'

describe TarkaMatchers::Helpers::Utility do
	let(:parent){ Class.new{ include( TarkaMatchers::Helpers::Utility ) }.new }

	let(:pass_default_proc){ Proc.new{ |args| parent.pass_default *args } }
	let(:pass_default){ pass_default_proc.call *pass_args }

	let(:negated_default_proc){ Proc.new{ |args| parent.pass_default *args } }
	let(:negated_default){ negated_default_proc.call *pass_args }

	let(:pass_with_message_proc){ Proc.new{ |args| parent.pass_with_message *args } }
	let(:pass_with_message){ pass_with_message_proc.call *pass_with_message_args }

	let(:pass_message){ 'this is the description foobar' }

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
		context 'when pass default is called' do
			before{ pass_default }
			context 'when no pass_args' do
				let(:pass_args){ [] }
				it{ is_expected.to eq 'pass' }
			end

			context 'with pass_args is "this is the description foobar"' do	
				let(:pass_args){ [pass_message] }
				it{ is_expected.to eq pass_message }
			end
		end

		context 'when pass_with_message is called' do
			before{ pass_with_message }
			context 'when no pass_with_message_args' do
				let(:pass_with_message_args){ [] }
				it{ is_expected.to eq nil }
			end

			context 'with pass_with_message_args is "this is the description foobar"' do	
				let(:pass_with_message_args){ [pass_message] }
				it{ is_expected.to eq pass_message }
			end
		end
	end

	describe '#failure_message_when_negated' do
		subject{ parent.failure_message_when_negated }
		context 'when pass default is called' do
			before{ pass_default }
			context 'when no pass_args' do
				let(:pass_args){ [] }
				it{ is_expected.to eq 'did pass' }
			end

			context 'with pass_args is "this is the description foobar"' do	
				let(:pass_args){ [pass_message] }
				it{ is_expected.to eq "did #{pass_message}" }
			end
		end

		context 'when pass_with_message is called' do
			before{ pass_with_message }
			context 'when no pass_with_message_args' do
				let(:pass_with_message_args){ [] }
				it{ is_expected.to eq nil }
			end

			context 'with pass_with_message_args is "this is the description foobar"' do	
				let(:pass_with_message_args){ [pass_message] }
				it{ is_expected.to eq nil }
			end
		end
	end

	describe '#failure_message' do
		subject{ parent.failure_message }
		context 'when pass default is called' do
			before{ pass_default }
			context 'when no pass_args' do
				let(:pass_args){ [] }
				it{ is_expected.to include "failed to pass" }
				it{ is_expected.to include "% identical" }
			end

			context 'with pass_args is "this is the description foobar"' do	
				let(:pass_args){ [pass_message] }
				it{ is_expected.to include "failed to #{pass_message}" }
				it{ is_expected.to include "% identical" }
			end
		end

		context 'when pass_with_message is called' do
			before{ pass_with_message }
			context 'when no pass_with_message_args' do
				let(:pass_with_message_args){ [] }
				it{ is_expected.to eq nil }
			end

			context 'with pass_with_message_args is "this is the description foobar"' do	
				let(:pass_with_message_args){ [pass_message] }
				it{ is_expected.to eq nil }
			end
		end
	end
end
