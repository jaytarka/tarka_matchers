require 'spec_helper'
require 'tarka_matchers/action_dispatch_matchers'

describe TarkaMatchers::Matchers::ActionDispatch do
	it{ is_expected.to respond_to :be_named_as } 
end
