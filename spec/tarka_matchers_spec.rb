require 'spec_helper'

describe TarkaMatchers do
	specify{ expect(TarkaMatchers::VERSION).to be_kind_of String }
end
