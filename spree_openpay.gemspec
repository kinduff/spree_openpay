$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'spree_openpay/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'spree_openpay'
  s.version     = SpreeOpenpay::VERSION
  s.authors     = ['Jonathan Garay', 'Fernando Barajas', 'Manuel Vidaurre', 'AngelChaos26']
  s.email       = %w(jonathan.garay@crowdint.com fernando.barajas@crowdint.com manuel.vidaurre@agiltec.com.mx)
  s.homepage    = 'https://github.com/elliotmx'
  s.summary     = 'Spree Engine for Openpay Mexican Payment gateway'
  s.description = 'Spree Engine for Openpay Mexican Payment gateway'

  s.files = Dir['{app,config,models,db,lib}/**/*'] + %w(MIT-LICENSE Rakefile README.md)


  s.add_dependency 'oj', '~> 2.14.0'
  s.add_dependency 'faraday'
  s.add_dependency 'typhoeus'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'activemerchant'
  s.add_dependency 'spree', '~> 3.0.0.rc2'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'celluloid'
end