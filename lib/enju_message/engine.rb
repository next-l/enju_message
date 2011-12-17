require 'delayed_job'
require 'devise'
require 'cancan'
require 'state_machine'
require 'inherited_resources'
require 'attribute_normalizer'
require 'configatron'
require 'addressable/uri'
require 'friendly_id'
require 'awesome_nested_set'
require 'will_paginate'
require 'sunspot_rails'

module EnjuMessage
  class Engine < Rails::Engine
  end
end
