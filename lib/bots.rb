#!/usr/bin/env ruby

require 'erasmus'
require 'erasmus/utils'

Erasmus::Bot.new("irc.freenode.net").join([
	Erasmus::Channel.new('erasmus-testing') \
		.extend(Utils::Foo) \
		.extend(Utils::Changelog) \
		.extend(Utils::FlagFloodProtection), \
	Erasmus::Channel.new('erasmus-testing2'),
]).run
