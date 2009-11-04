#!/usr/bin/env ruby

require 'erasmus'
require 'erasmus/utils'
require 'erasmus/examples'

Erasmus::Bot.new("irc.freenode.net").join([
	Erasmus::Channel.new('erasmus-testing') \
		.extend(Examples::Foo) \
		.extend(Utils::Changelog) \
		.extend(Utils::FlagFloodProtection), \
	Erasmus::Channel.new('erasmus-testing2'),
]).run
