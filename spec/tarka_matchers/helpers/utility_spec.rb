require 'spec_helper'
require 'tarka_matchers/utility'

describe TarkaMatchers::Helpers::Utility do
	let(:parent){ Class.new{ include( TarkaMatchers::Helpers::Utility ) }.new }

	let(:pass_default){ parent.pass_default *pass_args }
	let(:pass_args){ [] }

	let(:negated_default){ parent.pass_default *negated_args }
	let(:negated_args){ [] }

	let(:pass_with_message){ parent.pass_with_message *pass_with_message_args }	
	let(:pass_with_message_args){ [] }

	let(:fail_default){ parent.fail_default *fail_default_args }
	let(:fail_default_args){ [] }
	
	let(:pass_fallback_message){ 'pass' }

	let(:pass_message){ 'this is the description foobar' }
	let(:negated_message){ 'this is the negated messsage' }
	let(:fail_message){ 'this is the fail default messsage boozafooze' }

	let(:append_1){ 'hello this is the appended message' }
	let(:append_2){ 'hello this is the a second appended message that can be utilized' }

	let(:difference_format){ 'the difference is 80%' }
	let(:selected_format){ 'the selected is 80%' }

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
				it{ is_expected.to eq pass_fallback_message }
			end

			context 'with pass_args is "this is the description foobar"' do	
				let(:pass_args){ [pass_message] }
				it{ is_expected.to eq pass_message }
			end
		end

		context 'when pass_with_message is called' do
			before{ pass_with_message }
			context 'when no pass_with_message_args' do
				it{ is_expected.to eq nil }
			end

			context 'with pass_with_message_args is "this is the description foobar"' do	
				let(:pass_with_message_args){ [pass_message] }
				it{ is_expected.to eq pass_message }
			end
		end
	end

	describe '#failure_message_when_negated' do
		let(:prepend){ 'did' }
		subject{ parent.failure_message_when_negated }

		context 'when pass default and negated default is called' do
			before do
				pass_default
				negated_default
			end

			context 'when no pass_args' do
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}" }
			end

			context 'with pass_args is "this is the description foobar"' do	
				let(:negated_args){ [negated_message] }
				it{ is_expected.to eq "#{prepend} #{negated_message}" }
			end
		end

		context 'when pass default is called' do
			before{ pass_default }
			context 'when no pass_args' do
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}" }
			end

			context 'with pass_args is "this is the description foobar"' do	
				let(:pass_args){ [pass_message] }
				it{ is_expected.to eq "#{prepend} #{pass_message}" }
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
		let(:prepend){ 'failed to' }
		before{ allow(TarkaMatchers::Formatters::Difference).to receive(:difference).and_return(difference_format) }
		before{ allow(TarkaMatchers::Formatters::Selected).to receive(:selected).and_return(selected_format) }
		subject{ parent.failure_message }

		context 'when pass default is called' do
			before{ pass_default }
			context 'when no pass_args' do
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{difference_format}" }
			end

			context 'with pass_args is "this is the description foobar"' do	
				let(:pass_args){ [pass_message] }
				it{ is_expected.to eq "#{prepend} #{pass_message}#{difference_format}" }
			end
		end

		context 'when pass_with_message is called' do
			before{ pass_with_message }
			context 'when no pass_with_message_args' do
				it{ is_expected.to eq nil }
			end

			context 'with pass_with_message_args is "this is the description foobar"' do	
				let(:pass_with_message_args){ [pass_message] }
				it{ is_expected.to eq nil }
			end
		end

		context 'when pass default and fail default is called' do
			before do
				pass_default
				fail_default
			end

			context 'when there are no fail_default_args' do
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{difference_format}" }
			end

			context 'when fail_default_args is a string' do
				let(:fail_default_args){ fail_message }
				it{ is_expected.to eq "#{fail_message}" }
			end

			context 'when fail_default_args is just: string' do
				let(:fail_default_args){ [just: "#{fail_message}"] }
				it{ is_expected.to eq "#{fail_message}" }
			end

			context 'when fail_default_args is append: append_1' do
				let(:fail_default_args){ [append: "#{append_1}"] }
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{append_1}" }
			end

			context 'when fail_default_args is append: append_2' do
				let(:fail_default_args){ [append: "#{append_2}"] }
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{append_2}" }
			end

			context 'when fail_default_args is append: :difference' do
				let(:fail_default_args){ [append: :difference] }
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{difference_format}" }
			end

			context 'when fail_default_args is append: :selected' do
				let(:fail_default_args){ [append: :selected] }
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{selected_format}" }
			end

			context 'when pass_default_args is pass_message' do
			let(:pass_args){ pass_message }

				context 'when there are no fail_default_args' do
					it{ is_expected.to eq "#{prepend} #{pass_message}#{difference_format}" }

				context 'when there are no fail_default_args' do
					it{ is_expected.to eq "#{prepend} #{pass_message}#{difference_format}" }
				end

				context 'when fail_default_args is a string' do
					let(:fail_default_args){ fail_message }
					it{ is_expected.to eq "#{fail_message}" }
				end

				context 'when fail_default_args is just: string' do
					let(:fail_default_args){ [just: "#{fail_message}"] }
					it{ is_expected.to eq "#{fail_message}" }
				end

				context 'when fail_default_args is append: append_1' do
					let(:fail_default_args){ [append: "#{append_1}"] }
					it{ is_expected.to eq "#{prepend} #{pass_message}#{append_1}" }
				end

				context 'when fail_default_args is append: append_2' do
					let(:fail_default_args){ [append: "#{append_2}"] }
					it{ is_expected.to eq "#{prepend} #{pass_message}#{append_2}" }
				end

				context 'when fail_default_args is append: :difference' do
					let(:fail_default_args){ [append: :difference] }
					it{ is_expected.to eq "#{prepend} #{pass_message}#{difference_format}" }
				end

				context 'when fail_default_args is append: :selected' do
					let(:fail_default_args){ [append: :selected] }
					it{ is_expected.to eq "#{prepend} #{pass_message}#{selected_format}" }
				end
			end

		end

			context 'when fail_default_args is a string' do
				let(:fail_default_args){ fail_message }
				it{ is_expected.to eq "#{fail_message}" }
			end

			context 'when fail_default_args is just: string' do
				let(:fail_default_args){ [just: "#{fail_message}"] }
				it{ is_expected.to eq "#{fail_message}" }
			end

			context 'when fail_default_args is append: append_1' do
				let(:fail_default_args){ [append: "#{append_1}"] }
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{append_1}" }
			end

			context 'when fail_default_args is append: append_1' do
				let(:fail_default_args){ [append: "#{append_2}"] }
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{append_2}" }
			end

			context 'when fail_default_args is append: :difference' do
				let(:fail_default_args){ [append: :difference] }
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{difference_format}" }
			end

			context 'when fail_default_args is append: :selected' do
				let(:fail_default_args){ [append: :selected] }
				it{ is_expected.to eq "#{prepend} #{pass_fallback_message}#{selected_format}" }
			end
		end
	end
end
