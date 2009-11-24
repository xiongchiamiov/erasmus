module Admin
	module Control
		#def su(user)
		#	if user == @server.owner
		#		# check if idented
		#		if @server.server.include? 'freenode'
		#			if !@server.acc(user)[-1..-1] == "3"
		#				raise Erasmus::AuthenticationError
		#			end
		#		elsif @server.server.include? 'rizon'
		#			if !@server.status(user)[-1..-1] == "3"
		#				raise Erasmus::AuthenticationError
		#			end
		#		else
		#			raise Erasmus::AuthenticationError
		#		end
		#	else
		#		raise Erasmus::AuthenticationError
		#	end
		#end
		def su(user)
			if user == @server.owner
				# check if idented
				if @server.server.include? 'freenode'
					if !@server.acc(user)[-1..-1] == "3"
						raise Erasmus::AuthenticationError
					end
				elsif @server.server.include? 'rizon'
					if !@server.status(user)[-1..-1] == "3"
						raise Erasmus::AuthenticationError
					end
				else
					raise Erasmus::AuthenticationError
				end
			else
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
					end
				}
			}
		end
	end
end
