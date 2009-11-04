module Github
	module Issues
		require 'octopi'
		def self.extended(obj)
			obj.instance_eval {
				repo = Octopi::Repository.find("xiongchiamiov", "erasmus")
				
				@flags['issues'] = lambda { |user, host, arguments|
					if arguments[0] and arguments[0] =~ /^\d+$/
						begin
							# this only gives up after receiving 10 403s,
							# making it very easy to build up a large queue
							# perhaps we should get all issues, and just index?
							# http://github.com/fcoury/octopi/issues/#issue/36
							issue = repo.issue(arguments[0])
							say "Issue #{issue.number}: #{issue.title}"
						rescue Octopi::APIError
							say "No issue with id #{arguments[0]} found."
						end
					else
						begin
							repo.issues.each do |issue|
								say "Issue #{issue.number}: #{issue.title}"
							end
						rescue Octopi::APIError
							say "I'm having a problem connecting to GitHub.  Try again in a bit."
						end
					end
				}
				@flags['issue-detail'] = lambda { |user, host, arguments|
					if arguments[0] and arguments[0] =~ /^\d+$/
						begin
							issue = repo.issue(arguments[0])
							say "Issue #{issue.number}: #{issue.title} (reported by #{issue.user})"
							say "#{issue.body}"
							say 'http://github.com/xiongchiamiov/erasmus/issues/#issue/' + issue.number.to_s
						rescue Octopi::APIError
							say "No issue with id #{arguments[0]} found."
						end
					end
				}
			}
		end
	end
end
