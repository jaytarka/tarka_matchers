require 'spec_helper'
require 'tarka_matchers/matchers/matcher/fail'

RSpec.describe TarkaMatchers::Matchers::Matcher do
	let(:matcher){ subject }
	let(:normal_expectation){ expect(1).to eq argument }
	let(:negated_expectation){ expect(1).to_not eq argument }
	let(:not_met){ RSpec::Expectations::ExpectationNotMetError }

	specify{ expect(matcher).to respond_to :fail }

	describe '.fail' do
		let(:normal){ expect{ expectation }.to matcher.fail }
		let(:negated){ expect{ expectation }.to_not matcher.fail }

		context 'when expectation is normal_expectation' do
			let(:expectation){ normal_expectation }
			
			context 'when argument causes a pass' do
				let(:argument){ 2 }

				specify{ expect{ normal }.to_not raise_exception }
				specify{ expect{ negated }.to raise_exception not_met }
			end
		
			context 'when argument causes a failure' do
				let(:argument){ 1 }
	
				specify{ expect{ normal }.to raise_exception not_met }
				specify{ expect{ negated }.to_not raise_exception }
			end
		end

		context 'when expectation is negated_expectation' do
			let(:expectation){ negated_expectation }
			
			context 'when argument causes a pass' do
				let(:argument){ 2 }

				specify{ expect{ negated }.to_not raise_exception }
				specify{ expect{ normal }.to raise_exception not_met }
			end
		
			context 'when argument causes a failure' do
				let(:argument){ 1 }
	
				specify{ expect{ negated }.to raise_exception not_met }
				specify{ expect{ normal }.to_not raise_exception }
			end
		end
	end
end
