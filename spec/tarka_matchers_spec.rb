require 'spec_helper'

describe TarkaMatchers do
  describe 'version number' do
		subject { TarkaMatchers::VERSION }
		Then { is_expected.to be_kind_of String }
  end
end
