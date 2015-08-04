Gem::Specification.new do |s|
  s.name        = 'fiware-orion-geo'
  s.version     = '0.0.1'
  s.date        = '2014-08-03'
  s.summary     = "Interface for Orion server"
  s.description = "Gives you the possibility to simply interfear with Orion server (from Fiware) to insert and retreive data based on geolocalisation"
  s.authors     = ["Nikolaï POSNER"]
  s.email       = 'nikoposner@gmail.com'
  s.files       = ["lib/fiware-orion-geo.rb","lib/orion/geo/geo.rb"]
  s.homepage    = 'http://rubygems.org/gems/fiware-orion-geo'
  s.license     = 'MIT'

  s.add_runtime_dependency 'httparty', '~> 0'
end