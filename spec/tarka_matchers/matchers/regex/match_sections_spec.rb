require 'tarka_matchers/regex_matchers'
require 'the_great_escape'
require 'spec_helper'

describe TarkaMatchers::Matchers::Regex do
	subject{ described_class }
	it{ is_expected.to respond_to :match_sections }

	describe '#match_sections' do
		subject{ expect(article).to match_sections(*expected).when_used_on(string) }

		context 'when article is simple regex' do
			let(:article){ /\[\d{1,3}yuz\w/ }
			let(:string){ escape "hello [432yuza wowowmely\e[35ma [032yuzm awesome" }
			let(:expected){ [6,13,32,39] }

			context 'when string doesnt contain the pattern' do
				let(:string){ "helsome" }
				specify{ expect{ subject }.to fail }
				specify{ expect{ subject }.to have_a_failure_message_of "The string, '#{string}', does not contain the pattern, '#{article}'." }
			end

			context 'when expected is correct indexes' do
				
			end

			context 'when expected is correct content' do

			end

			context 'when expected is incorrect indexes' do

			end

			context 'when expected is incorrect content' do

			end

			context 'when expected contains a float' do
				let(:expected){ [6,13,32.000000000000001,39] }
				specify{ expect{ subject }.to fail }
				specify{ expect{ subject }.to have_a_failure_message_of "Provided a wrongly formatted argument to 'match_sections'. 'match_sections' expects an argument sequence consisting exclusively of either the start and end indexes of all expected sections of the provided string selected by the match, or an example of the actual text that is selected." }
			end

			context 'when expected is a mixture of content and indexes' do
			let(:expected){ [6,13,'hello','awesome'] }
				specify{ expect{ subject }.to fail }
				specify{ expect{ subject }.to have_a_failure_message_of  "Provided a wrongly formatted argument to 'match_sections'. 'match_sections' expects an argument sequence consisting exclusively of either the start and end indexes of all expected sections of the provided string selected by the match, or an example of the actual text that is selected." }
	
			end
		end

		context 'with complex regex' do

		end

		context 'with escaped string and regex to match SGR codes' do
			let(:article){ /\\e\[\d{1,3}m\K(?!\\e\[\d{1,3}m)(.+?)(?=\\e\[\d{1,3}m|$)/ }
			let(:expected){ "hello \e[37mI am friggin awesomely\e[35mawesome am\e[32mawesome" }

		end
	end
end
