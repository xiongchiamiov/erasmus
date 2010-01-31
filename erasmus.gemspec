# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{erasmus}
  s.version = "0.0.3"
  s.date = Time.now.strftime('%Y-%m-%d')

  s.authors = ["xiongchiamiov"]
  s.email = %q{xiong.chiamiov@gmail.com}
  
  s.files = %w( README.md Rakefile LICENSE )
  s.files += Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  
  s.summary = %q{A simple, modular irc bot/framework}
  s.homepage = %q{http://github.com/xiongchiamiov/erasmus}
  s.description = %q{A simple, modular irc bot/framework}
end
