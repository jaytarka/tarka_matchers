require 'tarka_matchers/formatters/difference'

def mock_formatter

end

def mock_formatters mocked_difference
	formatter = TarkaMatchers::Formatters::Difference
	formatter.instance_variable_set(:@mocked_difference,mocked_difference)
	@rspec_matchers = ::RSpec::Matchers
	@real_difference = formatter.singleton_method(:difference).unbind
	formatter.define_singleton_method(:difference_clone, @real_difference )
#	formatter.send(:define_method, :difference_clone){ |expected,actual| "hello m'lady, im a clone" }
#	ap formatter.difference @expected, @actual
	class <<formatter
		remove_method(:difference)
		define_method(:difference) do |expected,actual| 
			if caller[0].split('').last(9).join == "matches?'"
				@mocked_difference
			else
				self.difference_clone expected, actual
			end
		end
	end
end

def remove
	@rspec_matchers.send :remove_method, :expect
end

def redefine
	@rspec_matchers = ::RSpec::Matchers
	@real_expect = @rspec_matchers.instance_method :expect
	self.remove
	expect_capture = self
	@rspec_matchers.send(:define_method, :expect){ |target=:undefined, &block_target| expect_capture.new(target, block_target) }
end

def replace
	self.remove
	@rspec_matchers.send(:define_method, :expect, @real_expect)
end

shared_context 'formatter mock' do
	let(:difference_format){ 'this is the difference - 43.44% identical' }
	let(:selected_format){ 'this has been selected! - 40% matched' }
	before{ mock_formatters(difference_format) }
end
