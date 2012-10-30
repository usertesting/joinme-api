Gem::Specification.new do |s|
  s.name        = 'joinme-api'
  s.author      = 'Paul Hepworth'
  s.email       = 'paul<dot>hepworth<at>peppyheppy<dot>com'
  s.version     = '0.0.1'
  s.homepage    = 'https://github.com/peppyheppy/joinme-api'
  s.date        = '2012-10-29'
  s.summary     = "A gem that provides a basic wrapper for the join.me API"
  s.description = "A gem that provides a basic wrapper for the join.me API (https://secure.join.me/welcome/webhelp/joinme/join.me/c_joinme_API.html)"
  s.files       = s.files = `git ls-files`.split("\n")
  s.add_development_dependency "rspec", "2.6.0"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "guard-rspec", "~> 0.5"
  s.add_development_dependency "growl"
end

