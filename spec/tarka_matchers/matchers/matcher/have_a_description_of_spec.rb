require 'spec_helper'
require 'tarka_matchers/matchers/matcher/have_a_description_of'
require 'tarka_matchers/fixtures/foo_up_to'

describe TarkaMatchers::Matchers::Matcher do
	it{ is_expected.to respond_to :have_a_description_of }

	describe '.have_a_description_of' do
		specify{ expect{ expect{ expect(9833).to foo_up_to 458 }.to have_a_description_of 'hwhwhw' }.to fail }
		specify{ expect{ expect{ expect(9833).to foo_up_to 458 }.to have_a_description_of 'faz around.' }.to fail }
		specify{ expect{ expect{ expect(9833).to foo_up_to 458 }.to have_a_description_of 'should faz around.' }.to pass }
	end

end
