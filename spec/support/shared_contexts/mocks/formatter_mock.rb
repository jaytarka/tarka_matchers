shared_context 'formatter mock' do
	let(:difference_format){ 'this is the difference - 43.44% identical' }
	let(:selected_format){ 'this has been selected! - 40% matched' }
	before{ allow(TarkaMatchers::Formatters::Difference).to receive(:difference).and_return(difference_format) }
	before{ allow(TarkaMatchers::Formatters::Selected).to receive(:selected).and_return(selected_format) }
end
