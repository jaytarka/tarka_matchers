require 'tarka_matchers/matchers/expectation/pass'
require 'tarka_matchers/matchers/expectation/fail'
require 'tarka_matchers/matchers/expectation/have_a_description_of'
require 'tarka_matchers/matchers/expectation/have_a_failure_message_of'
require 'tarka_matchers/matchers/expectation/have_a_failure_message_when_negated_of'
require 'tarka_matchers/matchers/expectation/support_block_expectations'

class Object
	include TarkaMatchers::Matchers::Expectation
end
