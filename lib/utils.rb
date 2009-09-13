module Utils
	module Foo
		def handle_public_message(user, host, message)
			if message =~ /^#{@server.nick}:/
				hilight_user(user, 'whatcha want?')
			elsif message =~ /^#{@flag}(\S+)\s(.*)$/
				command = $1
				arguments = $2.split(/\s/)
				
				case command
				when 'foo'
					say('bar')
				when 'bar'
					notice_user(user, 'baz')
				when 'baz'
					notice_channel('not baz!')
				end
			end
		end
		
		def join
			@server.say "JOIN ##{@name}"
			say "#{1.chr}ACTION is here to help#{1.chr}"
		end
	end
end
