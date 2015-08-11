require 'spec_helper'
require 'tarka_matchers/matchers/matcher/pass'

RSpec.describe TarkaMatchers::Matchers::Matcher do
	it{ is_expected.to respond_to :pass }
	let(:unnegated){ expect{ expect(1).to eq argument }.to TarkaMatchers::Matchers::Matcher.pass }
	let(:negated){ expect{ expect(1).to_not eq argument }.to TarkaMatchers::Matchers::Matcher.pass }

	let(:not_met){ RSpec::Expectations::ExpectationNotMetError }

	context 'with passing arguments' do
		let(:argument){ 1 }

		specify{ expect{ unnegated }.to_not raise_exception }
		specify{ expect{ negated }.to raise_exception not_met  }
	end

	context 'with failing arguments' do
		let(:argument){ 2 }

		specify{ expect{ unnegated }.to raise_exception not_met }
		specify{ expect{ negated }.to_not raise_exception }
	end
end
