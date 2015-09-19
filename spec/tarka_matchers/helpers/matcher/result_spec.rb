require 'spec_helper'
require 'tarka_matchers/helpers/matcher/result'

describe TarkaMatchers::Helpers::Matcher::Result do
	let(:main){ TarkaMatchers::Helpers::Matcher::Result }
	subject{ main }
	it{ is_expected.to respond_to :pass? }
	
	describe '.pass?' do
		subject{ main.pass?{ block.call } }
		context 'when given block that will raise ExpectationNotMet' do
			let(:block){ Proc.new{ raise RSpec::Expectations::ExpectationNotMetError, 'you divided by zero!' } }
			specify{ expect(subject.message).to eq 'you divided by zero!' }
		end
		context 'when given block that will not raise ExpectationNotMet' do
			let(:block){ Proc.new{ seven = 4 + 2 } }
			it{ is_expected.to eq true }
		end
	end
end
