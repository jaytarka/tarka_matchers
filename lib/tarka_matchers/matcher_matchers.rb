require 'tarka_matchers/matchers/matcher/pass'
require 'tarka_matchers/matchers/matcher/fail'

class Object
	include TarkaMatchers::Matchers::Matcher
end
