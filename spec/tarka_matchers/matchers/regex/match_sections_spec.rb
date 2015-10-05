require 'tarka_matchers/regex_matchers'
require 'the_great_escape'
require 'spec_helper'

describe TarkaMatchers::Matchers::Regex do
	subject{ described_class }
	it{ is_expected.to respond_to :match_sections }
	
	describe '|indexes_list' do
		subject{ described_class.send :indexes_list }
	end

	describe '#match_sections' do
		subject{ Proc.new{ expect(actual).to match_sections(*expected).when_used_on(string) } }

		context 'when actual is simple regex' do
			let(:actual){ /\[\d{1,3}yuz\w/ }
			let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzm awesome" }
			let(:expected){ [6,13,32,39] }

			context 'when string doesnt contain the pattern' do
				let(:string){ "helsome" }
				it{ is_expected.to fail }
				it{ is_expected.to have_a_failure_message_of "The string, 'helsome', does not contain the pattern, '(?-mix:\\\\[\\\\d{1,3}yuz\\\\w)':Original: helsomeSelected: XXXXXXX - 0.0% matched" }
			end

			context 'when expected is has an odd number of indexes' do
				let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzm awesome" }
				let(:expected){ [6,13,32] }
				it{ is_expected.to fail }
				it{ is_expected.to have_a_failure_message_of "The indexes provided, '[6, 13, 32]', are of an odd number. Please provide the start and end index pairs of all sections of 'hello [432yuza wowowmely\\a [032yuzm awesome' that should be selected by '(?-mix:\\\\[\\\\d{1,3}yuz\\\\w)'." }
			end

			context 'when expected contains less index pairs than matches' do
				let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzm awesome" }
				let(:expected){ [6,13] }
				it{ is_expected.to fail }
				it{ is_expected.to have_a_failure_message_of "The index pairs provided, '[6, 13]', are less than the number of matches found in the string. Please provide the start and end index pairs of all sections of 'hello [432yuza wowowmely\\a [032yuzm awesome' that should be selected by '(?-mix:\\\\[\\\\d{1,3}yuz\\\\w)'."}
			end

			context 'when expected contains more index pairs than matches' do
				let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzm awesome" }
				let(:expected){ [6,13,32,46,54,122] }
				it{ is_expected.to fail }
				it{ is_expected.to have_a_failure_message_of "The index pairs provided, '[6, 13, 32, 46, 54, 122]', are more than the number of matches found in the string. Please provide the start and end index pairs of all sections of 'hello [432yuza wowowmely\\a [032yuzm awesome' that should be selected by '(?-mix:\\\\[\\\\d{1,3}yuz\\\\w)'." }
			end

			context 'when expected is one correct index pair' do
				let(:string){ escape "hello [432yuza wowowmely\e[35awesome" }
				let(:expected){ [6,13] }
				it{ is_expected.to pass }
				it{ is_expected.to have_a_description_of "should contain the pattern, '(?-mix:\\\\[\\\\d{1,3}yuz\\\\w)' at positions '6' to '13'." }
			end

			context 'when expected is two correct index pairs' do
				it{ is_expected.to pass }
				it{ is_expected.to have_a_description_of "should contain the pattern, '(?-mix:\\\\[\\\\d{1,3}yuz\\\\w)' at positions '6' to '13' and '32' to '39'." }
			end

			context 'when expected is three correct index pairs' do
				let(:actual){ /\[\d{1,3}yuz\w/ }
				let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzakzaw[555yuzak" }
				let(:expected){ [6,13,32,39,44,51] }
				it{ is_expected.to pass }
				it{ is_expected.to have_a_description_of "should contain the pattern, '(?-mix:\\\\[\\\\d{1,3}yuz\\\\w)' at positions '6' to '13','32' to '39' and '44' to '51'." }
			end

			context 'when expected is incorrect indexes' do
				let(:actual){ /\[\d{1,3}yuz\w/ }
				let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzakzaw[555yuzak" }
				let(:expected){ [5,9,21,28,33,49] }
				it{ is_expected.to fail }
				it{ is_expected.to have_a_failure_message_of "The string, 'hello [432yuza wowowmely\\a [032yuzakzaw[555yuzak', does not contain the pattern, '(?-mix:\\\\[\\\\d{1,3}yuz\\\\w)':Original: hello [432yuza wowowmely\\a [032yuzakzaw[555yuzakSelected: XXXXXX[432yuzaXXXXXXXXXXXXXXXXXX[032yuzaXXXX[555yuzaX - 45.283% matched"}
			end
			
			context 'when expected is content' do
				context 'when expected is correct content' do
					let(:actual){ /\[\d{1,3}yuz\w/ }
					let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzakzaw[555yuzak" }
					let(:expected){ ['[432yuza','[032yuza','[555yuza'] }

					it{ is_expected.to pass }
					it{ is_expected.to have_a_description_of '' }
				end

				context 'when expected is incorrect content' do
					let(:actual){ /\[\d{1,3}yuz\w/ }
					let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzakzaw[555yuzak" }
					let(:expected){  ['[432yuza','[032yuzk','[515yuzp']    }

					it{ is_expected.to fail }
					it{ is_expected.to have_a_failure_message_of '' }
				end
			end

			context 'when expected contains a float' do
				let(:expected){ [6,13,32.000000000000001,39] }
				it{ is_expected.to fail }
				it{ is_expected.to have_a_failure_message_of "Provided a wrongly formatted argument to 'match_sections'. 'match_sections' expects an argument sequence consisting exclusively of either the start and end indexes of all expected sections of the provided string selected by the match, or an example of the actual text that is selected." }
			end

			context 'when expected is a mixture of content and indexes' do
			let(:expected){ [6,13,'hello','awesome'] }
				it{ is_expected.to fail }
				it{ is_expected.to have_a_failure_message_of "Provided a wrongly formatted argument to 'match_sections'. 'match_sections' expects an argument sequence consisting exclusively of either the start and end indexes of all expected sections of the provided string selected by the match, or an example of the actual text that is selected." }
			end
		end

		context 'with complex regex' do

		end

		context 'with escaped string and regex to match SGR codes' do
			let(:actual){ /\\e\[\d{1,3}m\K(?!\\e\[\d{1,3}m)(.+?)(?=\\e\[\d{1,3}m|$)/ }
			let(:expected){ escape "hello \e[37mI am friggin awesomely\e[35mawesome am\e[32mawesome" }

		end
	end
end
