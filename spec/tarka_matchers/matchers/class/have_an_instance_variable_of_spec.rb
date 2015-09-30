require 'spec_helper'
require 'tarka_matchers/class_matchers'

describe TarkaMatchers::Matchers::Class do
	it{ is_expected.to respond_to :have_an_instance_variable_of }
	describe '#have_an_instance_variable_of' do
		subject{ Proc.new{ expect(actual).to have_an_instance_variable_of(instance_variable).that_equals(expected) } }

		context 'when class is baz' do
			let(:actual){ Baz }
			let(:instance_variable){ :@bazzy }
			
			context "when expected is 'wooooop!'" do
				let(:expected){ 'wooooop!' }

				it{ is_expected.to pass }
			end
		end
	end
end	
