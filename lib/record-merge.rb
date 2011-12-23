# Top level include file that brings in all the necessary code
require 'bundler/setup'

require 'nokogiri'
require 'json'
require 'health-data-standards'

require_relative 'sorter'
require_relative 'merger'
require_relative 'processor'
