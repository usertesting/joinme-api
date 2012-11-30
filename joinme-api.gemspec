require './lib/joinme-api/version'

Gem::Specification.new do |s|
  s.name    = 'joinme-api'
  s.version = Joinme::VERSION
  s.authors      = ['Paul Hepworth', 'Ryan Montgomery']
  s.email       = ['paul<dot>hepworth<at>peppyheppy<dot>com', 'rmontgomery429<at>gmail<dot>com']
  s.description = "A simple library for communicating with the join.me API (https://secure.join.me/welcome/webhelp/joinme/join.me/c_joinme_API.html)"
  s.summary     = "A simple library for communicating with the join.me API"
  s.homepage    = 'https://github.com/peppyheppy/joinme-api'
  s.license     = 'MIT'

  s.platform      = Gem::Platform::RUBY
  s.require_paths = %w[lib]
  s.files         = s.files = `git ls-files`.split("\n")
  s.test_files    = Dir['spec/**/*.rb']

  s.add_development_dependency 'rspec', '2.12.0'
  s.add_development_dependency 'debugger'
  s.add_development_dependency 'rb-fsevent', '~>0.9.2'
  s.add_development_dependency 'guard', '~>1.5.2'
  s.add_development_dependency 'guard-bundler', '~>1.0.0'
  s.add_development_dependency 'guard-rspec', '~>2.1.0'
  s.add_development_dependency 'growl', '~>1.0.3'
  s.add_development_dependency 'webmock', '~>1.8.11'

  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.rdoc_options     = ['--line-numbers', '--inline-source', '--title', 'joinme-api', '--main', 'README.md']
end

