#!/usr/bin/env ruby

require 'erasmus'
require 'utils'

bot = Erasmus::Bot.new("irc.freenode.net")
erasmus_testing = Erasmus::Channel.new('erasmus-testing')
erasmus_testing.extend Utils::Foo
erasmus_testing2 = Erasmus::Channel.new('erasmus-testing2')
bot.join([erasmus_testing,erasmus_testing2])

trap("INT"){ bot.quit }

bot.run
