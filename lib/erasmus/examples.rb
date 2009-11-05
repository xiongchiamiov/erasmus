module Examples
	module Foo
		def handle_private_message(user, host, message)
			pm_user(user, 'hey!')
		end
		
		# this is how we handle flags that the bot will respond to
		def self.extended(obj)
			obj.instance_eval {
				@flags['foo'] = lambda { |user, host, arguments, source|
					say('bar')
				}
				@flags['bar'] = lambda { |user, host, arguments, source|
					if source == :hilight
						notice_user(user, 'baz')
					end
					if source == :flag
						say("Hey everyone, #{user} wants to bar.")
					end
				}
				@flags['baz'] = lambda { |user, host, arguments, source|
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
