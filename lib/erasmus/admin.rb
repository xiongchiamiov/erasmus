module Admin
	module Control
		def su(user)
			# check if owner and idented
			if !(user == @server.owner and @server.acc(user) == "3")
					raise Erasmus::AuthenticationError
			end
		end
		def self.extended(obj)
			obj.instance_eval {
				@flags['stop'] = lambda { |user, host, arguments, source|
					begin
						su user
						@server.quit
					rescue Erasmus::AuthenticationError
						notice_user(user, "I'm sorry, but I can't allow you to do that.")
					rescue Exception => e
						raise
					end
				}
			}
		end
	end
end
