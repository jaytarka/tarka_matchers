require 'spec_helper'
require 'tarka_matchers/matchers/rails/action_dispatch/be_named_as'

describe ActionDispatch do
	it{ is_expected.to respond_to :zupp } 
end
