require 'spec_helper'
require 'tarka_matchers/expectation_matchers'

describe Object do
	subject { described_class }
	it{ is_expected.to respond_to :pass }
	it{ is_expected.to respond_to :fail }
	it{ is_expected.to respond_to :have_a_description_of }
	it{ is_expected.to respond_to :have_a_failure_message_of }
	it{ is_expected.to respond_to :have_a_failure_message_when_negated_of }
	it{ is_expected.to respond_to :support_block_expectations }
end
