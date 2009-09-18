module Utils
	module Foo
		def handle_hilight(user, host, message)
			hilight_user(user, 'whatcha want?')
		end
		
		def self.extended(obj)
			obj.instance_eval {
				@flags = {} if @flags.nil?
				@flags['foo'] = lambda { |user, host, arguments|
					say('bar')
				}
				@flags['bar'] = lambda { |user, host, arguments|
					notice_user(user, 'baz')
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
	
	module Changelog
		def self.extended(obj)
			obj.instance_eval {
				@flags = {} if @flags.nil?
				@flags['changelog'] = lambda { |user, host, arguments|
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
				}
			}
		end
	end
end
