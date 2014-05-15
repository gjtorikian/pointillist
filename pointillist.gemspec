require File.expand_path('../lib/pointillist/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'pointillist'
  s.version = Pointillist::VERSION

  s.summary = 'Uses Atom stylesheets for syntax highlighting.'
  s.description = 'Pointillist converts Atom stylesheets for use by Ruby, as a replacement to Pygments.'

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

  s.add_development_dependency 'rake'
end
