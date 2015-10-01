require 'spec_helper'
require 'tarka_matchers/class_matchers'

describe TarkaMatchers::Matchers::Class do
	it{ is_expected.to respond_to :have_an_instance_variable_of }
	describe '#have_an_instance_variable_of' do
		let(:matcher){ have_an_instance_variable_of(instance_variable).that_equals(expected) }
		context 'when normal' do
			subject{ Proc.new{ expect(actual).to matcher } }

			context 'when class is baz' do
				let(:actual){ Baz }
				let(:instance_variable){ :@bazzy }
				
				context "when expected is 'wooooop!'" do
					let(:expected){ 'wooooop!' }
					it{ is_expected.to_not support_block_expectations }
					it{ is_expected.to pass }
					it{ is_expected.to have_a_description_of "should contain an instance variable called, '#{instance_variable}', that equals '#{expected}'." }
				end

				context "when expected is 'derpage'" do
					let(:expected){ 'derpage' }

					it{ is_expected.to fail }
					it{ is_expected.to have_a_failure_message_of("xxx").keep_colors }
				end
			end
		end

		context 'when negated' do
			subject{ Proc.new{ expect(actual).to_not matcher } }

			context 'when class is baz' do
				let(:actual){ Baz }
				let(:instance_variable){ :@bazzy }
				
				context "when expected is 'wooooop!'" do
					let(:expected){ 'wooooop!' }

					it{ is_expected.to fail }
					it{ is_expected.to have_a_failure_message_when_negated_of "did contain an instance variable called, '#{instance_variable}', that equals '#{expected}'." }
				end

				context "when expected is 'derpage'" do
					let(:expected){ 'derpage' }

					it{ is_expected.to pass }
					it{ is_expected.to have_a_description_of "should not contain an instance variable called, '#{instance_variable}', that equals '#{expected}'." }
				end
			end
		end
	end
end	
