#!/usr/bin/env ruby

require 'socket'

module Erasmus
	class Bot
		attr_reader :nick
		
		def initialize(server, port=6667)
			@nick = 'mpu_test'
			@channels = {}
			@socket = TCPSocket.open(server, port)
			say "NICK #{@nick}"
			say "USER #{@nick} 0 * #{@nick}"
		end
		
		def join(channels)
			channels.each do |channel|
				channel.server = self
				channel.join
				@channels[channel.name] = channel
			end
			
			#return self so we can chain methods
			self
		end
	
		def say(msg)
			puts msg
			@socket.puts msg
		end
	
		def say_to_channel(channel, message)
			say "PRIVMSG ##{channel} :#{message}"
		end
	
		def pm_user(user, message)
			say "PRIVMSG #{user} :#{message}"
		end
		
		def notice_user(user, message)
			say "NOTICE #{user} :#{message}"
		end
		
		def notice_channel(channel, message)
			say "NOTICE ##{channel} :#{message}"
		end
		
		def run
			until @socket.eof? do
				msg = @socket.gets
				puts msg
				
				case msg
				when /^PING :(.*)$/
					say "PONG #{$1}"
				# channel messages
				when /^:(.*)!(.*) PRIVMSG #(\S+) :(.*)$/
					user = $1
					host = $2
					channel = $3
					content = $4
					@channels[channel].handle_public_message(user, host, content)
				# actual private messages
				when /^:(.*)!(.*) PRIVMSG \S+ :(.*)$/
					user = $1
					host = $2
					content = $3
					handle_private_message(user, host, content)
				end
			end
		end
		
		def handle_private_message(user, host, message)
			pm_user(user, 'hey!')
		end
	
		def quit
			@channels.each do |name, channel|
				channel.part
			end
			say 'QUIT'
		end
	end
	
	class Channel
		attr_accessor :server
		attr_reader :name
		
		def initialize(channel, flag='!')
			@name = channel
			@flag = flag
			
			@flags = {}
		end
		
		def join
			@server.say "JOIN ##{@name}"
		end
		
		def part(message='Bai~')
			@server.say "PART ##{@name} :#{message}"
		end
		
		def say(message)
			@server.say_to_channel(@name, message)
		end
		
		def hilight_user(user, message)
			@server.say_to_channel(@name, "#{user}: #{message}")
		end
		
		def notice_user(user, message)
			@server.notice_user(user, message)
		end
		
		def notice_channel(message)
			@server.notice_channel(@name, message)
		end
		
		def handle_public_message(user, host, message)
			if message =~ /^#{@server.nick}: (.*)$/
				handle_hilight(user, host, $1)
			elsif message =~ /^#{@flag}(\S+)\s(.*)$/
				command = $1
				arguments = $2.split(/\s/)
				handle_flag(user, host, command, arguments)
			end
		end
		
		def handle_hilight(user, host, message)
		end
		def handle_flag(user, host, flag, arguments)
			@flags = {} if !defined? @flags
			begin
				@flags[flag].call(user, host, arguments)
			rescue NoMethodError
				#say("Sorry, there's no action associated with the flag #{flag}.")
			end
		end
	end
end
