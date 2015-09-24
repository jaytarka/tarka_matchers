require 'spec_helper'
require 'tarka_matchers/formatters/selected'

describe TarkaMatchers::Formatters::Selected do
	subject{ described_class }
	it{ is_expected.to respond_to :selected }
end
