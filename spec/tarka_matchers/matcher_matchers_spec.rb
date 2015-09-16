require 'spec_helper'
require 'tarka_matchers/matcher_matchers'

describe Object do
	subject { Object }
	it{ is_expected.to respond_to :pass }
	it{ is_expected.to respond_to :fail }
end
