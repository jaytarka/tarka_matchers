require 'spec_helper'
require 'tarka_matchers/matchers/rails/action_dispatch/be_named_as'

describe TarkaMatchers::Matchers::ActionDispatch::BeNamedAsMatcher do
	describe '#initialize' do
		subject { described_class.new(:omgwtfbbq) }
		it { expect( subject.instance_variable_get(:@route_name) ).to eq :omgwtfbbq }
	end
	describe '#description' do
		context 'when :root' do
			subject { described_class.new(:root).description }
			it { is_expected.to eq "be named as root" }
		end
		context 'when :foobar' do
			subject { described_class.new(:foobar).description }
			it { is_expected.to eq "be named as foobar" }
		end
	end
end
