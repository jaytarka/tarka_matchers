require 'spec_helper'
require 'tarka_matchers/rails_matchers'

describe Object do
	subject { described_class }
	it{ is_expected.to respond_to :be_named_as }
end
