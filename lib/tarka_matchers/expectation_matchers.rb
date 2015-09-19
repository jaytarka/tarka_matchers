require 'tarka_matchers/matchers/expectation/pass'
require 'tarka_matchers/matchers/expectation/fail'

class Object
	include TarkaMatchers::Matchers::Expectation
end
