require 'tarka_matchers/formatters/difference'
require 'tarka_matchers/formatters/selected'

shared_context 'mocked formatters' do
	let(:difference_format){ 'this is the difference - 43.44% identical' }
	let(:selected_format){ 'this has been selected! - 40% matched' }
	before do 
		mock_formatter(TarkaMatchers::Formatters::Difference, :difference, difference_format)
		mock_formatter(TarkaMatchers::Formatters::Selected, :selected, selected_format)
	end
end
