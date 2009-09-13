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
	
	module Changelog
		def handle_public_message(user, host, message)
			if message =~ /^#{@flag}(\S+)\s(.*)$/
				command = $1
				arguments = $2.split(/\s/)
				
				case command
				when 'changelog'
					if arguments[0] and arguments[0] =~ /^[\w\d "]+$/
						output = `git --no-pager log --pretty=format:%s --since=#{arguments[0]}`
					else
						output = `git --no-pager log --pretty=format:%s -1`
					end
					if output.empty?
						say "No changes found for specified period of time."
					else
						for summary in output.split("\n")
							say summary
						end
					end
				end
			end
		end
	end
end
