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
				let(:expected){ 'wooooop!' }

				it{ is_expected.to pass }
				it{ is_expected.to have_a_description_of "should contain an instance variable called, '#{instance_variable}', that equals '#{escape(expected.to_s)}'." }

				context 'when instance_variable doest exist' do
					let(:instance_variable){ :@blarsey }

					context "when expected is ['wow','woo','zoo']" do
						let(:expected){ ['wow','woo','zoo'] }

						it{ is_expected.to fail }
						it{ is_expected.to have_a_failure_message_of("failed to contain an instance variable called '@blarsey'. It does not exist inside the class.") }
					end
				end

				context 'when instance_variable is :@tazzy' do
					let(:instance_variable){ :@tazzy }

					context "when expected is ['wow','woo','zoo']" do
						let(:expected){ ['wow','woo','zoo'] }
						it{ is_expected.to pass }
						it{ is_expected.to have_a_description_of "should contain an instance variable called, '#{instance_variable}', that equals '#{escape(expected.to_s)}'." }
					end

					context "when expected is ['wow','woz','zooper']" do
						include_context 'formatter mock'
						let(:expected){ ['wow','woz','zooper'] }
						it{ is_expected.to fail }
						it{ is_expected.to have_a_failure_message_of "xfailed to contain an instance variable called, '#{instance_variable}', that equals '#{escape(expected.to_s)}'.#{difference_format}" }
					end
				end

				context "when expected is ['zaney','xab']" do
					let(:expected){ ['zaney','xab'] }
					it{ is_expected.to fail }
					it{ is_expected.to have_a_failure_message_of("failed to contain an instance variable called, '#{instance_variable}', that equals '#{escape(expected.to_s)}'.Expected: #{escape(expected.to_s)}  Actual: wooooop!XXXXXXXX - 0.0% identical") }
				end

				context "when expected is 'derpage'" do
					let(:expected){ 'derpage' }

					it{ is_expected.to fail }
					it{ is_expected.to have_a_failure_message_of("failed to contain an instance variable called, '#{instance_variable}', that equals '#{escape(expected.to_s)}'.Expected: #{escape(expected.to_s)}X  Actual: wooooop! - 0.0% identical") }
				end

				context "when expected is ['derpage','merpage','slurpage','perp']" do
					let(:expected){ ['derpage','merpage','slurpage','perp'] }

					it{ is_expected.to fail }
					it{ is_expected.to have_a_failure_message_of("failed to contain an instance variable called, '#{instance_variable}', that equals '#{escape(expected.to_s)}'.Expected: #{escape(expected.to_s)}  Actual: wooooop!XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - 0.0% identical") }
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
