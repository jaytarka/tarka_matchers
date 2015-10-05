$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tarka_matchers'
require 'tarka_matchers/expectation_matchers'
require 'rspec/given'
require 'faker'
require 'awesome_print'
require 'the_great_escape'

require 'support/fixtures/expectations/baz_up_to'
require 'support/fixtures/expectations/foo_up_to'
require 'support/fixtures/expectations/rawrg_up_to'

require 'support/fixtures/classes/baz'

require 'support/shared_contexts/mocks/formatter_mock'
