module Examples
	module Foo
		def handle_private_message(user, host, message)
			pm_user(user, 'hey!')
		end
	
		def handle_hilight(user, host, message)
			hilight_user(user, 'whatcha want?')
		end
		
		# this is how we handle flags that the bot will respond to
		def self.extended(obj)
			obj.instance_eval {
				@flags['foo'] = lambda { |user, host, arguments|
					say('bar')
				}
				@flags['bar'] = lambda { |user, host, arguments|
					notice_user(user, 'baz')
					say("Hey everyone, #{user} wants to bar.")
				}
				@flags['baz'] = lambda { |user, host, arguments|
					notice_channel('not baz!')
				}
			}
		end
		
		def join
			@server.say "JOIN ##{@name}"
			say "#{1.chr}ACTION is here to help#{1.chr}"
		end
	end	
end
