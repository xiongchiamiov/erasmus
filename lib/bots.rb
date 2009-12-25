#!/usr/bin/env ruby

# Define your bots in here.

require 'erasmus'
require 'erasmus/utils'
require 'erasmus/github'
require 'erasmus/examples'
require 'erasmus/admin'

Erasmus::Bot.new("irc.freenode.net").join([
	Erasmus::Channel.new('erasmus-testing') \
		.extend(Examples::Foo) \
		.extend(Github::Issues) \
		.extend(Admin::Control) \
		.extend(Utils::Changelog) \
		.extend(Utils::FlagFloodProtection), \
	Erasmus::Channel.new('erasmus-testing2'),
]).run
