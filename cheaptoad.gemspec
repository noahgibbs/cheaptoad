version = "0.0.6"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'cheaptoad'
  s.version     = version
  s.summary     = 'Catch hoptoad notices from your app.'
  s.description = 'Add just a couple of lines to your app, and have it receive exceptions from your other apps via the hoptoad_notifier.'

  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Noah Gibbs'
  s.email             = 'noah_nospam_gibbs@remove_nospam.yahoo.com'
  s.homepage          = 'http://github.com/noahgibbs'
  s.rubyforge_project = 'cheaptoad'

  s.files = File.read("Manifest.txt").split
  s.require_path = 'lib'

  s.has_rdoc = false

  s.add_dependency('rails', '~> 2.3.2')
end
