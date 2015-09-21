require 'spec_helper'
require 'tarka_matchers/sgr_matchers'

describe TarkaMatchers::Matchers::SGR do
	it{ is_expected.to respond_to :be_red } 
end
