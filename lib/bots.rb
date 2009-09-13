#!/usr/bin/env ruby

require 'erasmus'
require 'utils'

Erasmus::Bot.new("irc.freenode.net").join([
	Erasmus::Channel.new('erasmus-testing').extend(Utils::Foo),
	Erasmus::Channel.new('erasmus-testing2'),
]).run
