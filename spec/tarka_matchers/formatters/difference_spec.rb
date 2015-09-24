require 'spec_helper'
require 'tarka_matchers/formatters/difference'

describe TarkaMatchers::Formatters::Difference do
	subject{ described_class }
	it{ is_expected.to respond_to :difference }
	describe '.difference' do
		subject{ described_class.difference(expected, actual) }
		xcontext 'when actual is longer than expected through use of spaces' do
			let(:expected){ 'h c' }
			let(:actual){ 'h zz' }
			it{ is_expected.to eq "\e[32mExpected: \e[42m\e[30mh c\e[0m\n\e[31m  Actual: \e[42m\e[30mh\e[42m\e[30m \e[41m\e[37m \e[0m\e[31m - 0% identical\e[0m" }
		end

		context 'when actual is 0% identical to expected' do
			let(:expected){ 'h' }
			let(:actual){ '' }
			it{ is_expected.to include '0.0%' }
		end

		context 'when actual is 50% identical to expected' do
			let(:expected){ 'h' }
			let(:actual){ 'ho' }
			it{ is_expected.to include '50.0%' }
		end
		
		context 'when actual is 75% identical to expected' do
			let(:expected){ 'hfff' }
			let(:actual){ 'hff' }
			it{ is_expected.to include '75.0%' }
		end

		context 'when actual is 100% identical to expected' do
			let(:expected){ ' b x' }
			let(:actual){ ' b x' }
			it{ is_expected.to include '100.0%' }
		end

		context 'when expected is 0% identical to actual' do
			let(:expected){ '' }
			let(:actual){ 'x' }
			it{ is_expected.to include '0.0%' }
		end

		context 'when expected is 50% identical to actual' do
			let(:expected){ 'ho' }
			let(:actual){ 'h' }
			it{ is_expected.to include '50.0%' }
		end
		
		context 'when expected is 75% identical to actual' do
			let(:expected){ '   ' }
			let(:actual){ '    ' }
			it{ is_expected.to include '75.0%' }
		end

		context 'when expected is 100% identical to actual' do
			let(:expected){ ' xc' }
			let(:actual){ ' xc' }
			it{ is_expected.to include '100.0%' }
		end



		xcontext 'when expected string is identical to actual string' do
			let(:expected){ 'helloeveryonejustastring here!!' }
			let(:actual){ expected }
			it{ is_expected.to eq "\e[31mExpect: helloeveryonejustastring here!!\n\e[32mActual: \e[42m\e[30mh\e[42m\e[30me\e[42m\e[30ml\e[42m\e[30ml\e[42m\e[30mo\e[42m\e[30me\e[42m\e[30mv\e[42m\e[30me\e[42m\e[30mr\e[42m\e[30my\e[42m\e[30mo\e[42m\e[30mn\e[42m\e[30me\e[42m\e[30mj\e[42m\e[30mu\e[42m\e[30ms\e[42m\e[30mt\e[42m\e[30ma\e[42m\e[30ms\e[42m\e[30mt\e[42m\e[30mr\e[42m\e[30mi\e[42m\e[30mn\e[42m\e[30mg\e[42m\e[30m \e[42m\e[30mh\e[42m\e[30me\e[42m\e[30mr\e[42m\e[30me\e[42m\e[30m!\e[42m\e[30m!\e[0m" }
		end

		xcontext 'when expected string is shorter but otherwise identical to actual string' do
			let(:expected){ 'hello' }
			let(:actual){ 'hellopeeps' }
			it{ is_expected.to eq "\e[32mExpect: #{expected}\nActual: \e[32mh\e[32me\e[32ml\e[32ml\e[32mo\e[31mp\e[31me\e[31me\e[31mp\e[31ms\e[0m" }
		end

		xcontext 'when expected string is shorter and different to actual string' do
			let(:expected){ 'helloeveryonejustastring here!!' }
			let(:actual){   'aeffeeveryoneawiofjaiwoz  fjwioajfwioajfeioaieee!!' }
			it{ is_expected.to eq "\e[32mExpect: #{expected}\nActual: \e[0m" }
		end

		xcontext 'when expected string is longer but otherwise identical to actual string' do
			let(:expected){ 'helloeveryonejustastring here!!' }
			let(:actual){ 'helloeveryone' }
			it{ is_expected.to eq "\e[32mExpect: #{expected}\nActual: \e[0m" }
		end

		xcontext 'when expected string is longer and different to actual string' do
			let(:expected){ 'helloeveryonejustastring here!!' }
			let(:actual){ 'heaoijeaoijenneeeeeee' }
			it{ is_expected.to eq "\e[32mExpect: #{expected}\nActual: \e[0m" }
		end
	end
end
