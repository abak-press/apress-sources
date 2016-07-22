# coding: utf-8
require 'bundler/setup'
require 'pry-debugger'

require 'simplecov'
SimpleCov.start 'rails' do
  minimum_coverage 95
  add_filter 'lib/apress/sources/version'
end

require 'combustion'
Combustion.initialize!
