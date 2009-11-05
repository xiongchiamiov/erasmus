module Utils
	module Changelog
		def self.extended(obj)
			obj.instance_eval {
				@flags['changelog'] = lambda { |user, host, arguments, source|
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
	
	module FlagFloodProtection
		require 'erasmus'
		require 'thread' # for Queue
		
		def self.extended(obj)
			obj.instance_eval {
				@userMessages = Hash.new(Queue.new)
				@blacklists << lambda { |user|
					@userMessages[user] << Time.now
					
					# don't allow messages from users who have sent
					# 5 messages in 15 seconds
					if @userMessages[user].length > 4 \
					and Time.now - @userMessages[user].pop < 15
						say("#{user} is flooding!")
						raise Erasmus::NotAllowedException
					end
				}
			}
		end
	end
end
