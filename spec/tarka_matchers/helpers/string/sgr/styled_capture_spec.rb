require 'tarka_matchers/helpers/string/sgr/styled_capture'
xdescribe TarkaMatchers::Helpers::SGR::StyledCapture do
	subject { described_class }
	it{ is_expected.to respond_to :capture }
	it{ is_expected.to respond_to :indexes_of }

	describe '.capture' do
		let(:number){ 3 }
		subject{ described_class.capture string, number }

		context 'when string contains no SGR codes' do
			let(:string){ 'hellomydarlinghellomysunshine' }
			it{ is_expected.to eq [] }
		end

		context 'when string contains 5 sgr codes with duplicates' do
			let(:string){ "I am some \e[67m styled \e[31m yeah woop \e[31m dsad \e[32m sdf \e[33m killll \e[30m sdfsdfasdf \e[34m zzaaazzz"  }
			it{ is_expected.to eq [67, 31, 32] }
		end

		context 'when number is larger than the number of styled sections' do
			let(:number){ 5 }
			let(:string){ "I am some \e[67m styled \e[31m oop \e[31m dsad \e[18m again" }
			it{ is_expected.to eq [67, 31, 18] }
		end
		
		context 'when number is less than the number of styled sections and there are no duplicates' do
			let(:number){ 2 }
			let(:string){ "I am some \e[67m styled \e[31m oop \e[35m dsad \e[18m again" }
			it{ is_expected.to eq [67, 31, 35] }
		end
	end

	describe '.indexes_of' do
		subject{ described_class.indexes_of string, regex }
		let(:string){ '"Only joking!" joked Joker.' }

		context 'when regex doesnt exist in string' do
			let(:regex){ /[42]/ }
			it{ is_expected.to eq [] }
		end

		context 'when regex exists in string' do
			let(:regex){ /[jJ]ok/ }
			it{ is_expected.to eq [6,15,21] }
		end

		context 'when utilizing the styled regex' do
			let(:regex){ described_class::STYLED }
			let(:string){ "I am some \e[67m styled \e[31m yeah woop \e[31m dsad \e[32m sdf \e[33m killll \e[30m sdfsdfasdf \e[34m zzaaazzz"  }
			it{ is_expected.to eq [67, 31, 32] }
		end

		context 'when utilizing the styled regex' do
			let(:regex){ described_class::STYLED }
			let(:string){ "Iamsme\e[67mstyled\e[31myeahwoop\e[31mdsad\e[32mdf\e[33mkillll\e[30msdfsdfasdf\e[34mzzaaazzz"  }
			it{ is_expected.to eq [67, 31, 32] }
		end
	end
end
