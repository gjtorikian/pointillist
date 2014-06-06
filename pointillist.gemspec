require File.expand_path('../lib/pointillist/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'pointillist'
  s.version = Pointillist::VERSION

  s.summary = 'Convert Atom\'s stylesheets into Pygments-compatible HTML.'
  s.description = 'Pointillist converts the same syntax highlighting rules used by Atom into an HTML format that is comprehensible by stylesheets designed for Pygments.'

  s.homepage = 'https://github.com/gjtorikian/pointillist'
  s.has_rdoc = false

  s.authors = ['Garen Torikian']
  s.email = ['gjtorikian@gmail.com']
  s.license = 'MIT'

  s.files         = %w(LICENSE.txt README.md Rakefile pointillist.gemspec)
  s.files        += Dir.glob("languages/**/*")
  s.files        += Dir.glob("lib/**/*.rb")
  s.test_files    = Dir.glob("test/**/*")
  s.require_paths = ['lib']

  s.add_dependency 'textpow', '~> 1.3.1'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'pygments.rb'
  s.add_development_dependency 'ruby-prof'
end
