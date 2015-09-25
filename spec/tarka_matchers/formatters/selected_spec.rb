require 'spec_helper'
require 'tarka_matchers/formatters/selected'

describe TarkaMatchers::Formatters::Selected do
	subject{ described_class }
	it{ is_expected.to respond_to :selected }

	describe '.selected' do
		subject{ described_class.selected string, selected }
		let(:string){ 'the cat sat on the m' }
		
		context 'when selected is empty' do
			let(:selected){ [] }
			it{ is_expected.to include '0.0%' }
		end
		
		context 'when selected is 50%' do
			let(:string){ 'as' }
			let(:selected){ [0,0] }
			it{ is_expected.to include '50.0%' }		
		end

		context 'when selected is 50%' do
			let(:selected){ [0,9] }
			it{ is_expected.to include '50.0%' }		
		end

		context 'when selected is 75.0%' do	
			let(:selected){ [0,14] }
			it{ is_expected.to include '75.0%' }
		end

		context 'when selected is 100%' do
			let(:selected){ [0,20] }
			it{ is_expected.to include '100.0%' }		
		end
	end
end
