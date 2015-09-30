require 'spec_helper'
require 'tarka_matchers/class_matchers'

describe TarkaMatchers::Matchers::Class do
	it{ is_expected.to respond_to :have_an_instance_variable_of }
	describe '#have_an_instance_variable_of' do
		subject{ Proc.new{ expect(actual).to match_sections(*expected).when_used_on(string) } }
	end
end	
