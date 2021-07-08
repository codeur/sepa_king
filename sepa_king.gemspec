lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sepa_king/version'

Gem::Specification.new do |s|
  s.name          = 'sepa_king_codeur'
  s.version       = SEPA::VERSION
  s.authors       = ['Georg Leciejewski', 'Georg Ledermann', 'Codeur']
  s.email         = ['gl@salesking.eu', 'mail@georg-ledermann.de', 'dev@codeur.com']
  s.description   = 'Implemention of pain.001.002.03 and pain.008.002.02 (ISO 20022)'
  s.summary       = 'Ruby gem for creating SEPA XML files'
  s.homepage      = 'http://github.com/codeur/sepa_king'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.metadata['homepage_uri'] = s.homepage
  s.metadata['source_code_uri'] = 'https://github.com/codeur/sepa_king'

  s.required_ruby_version = '>= 2.2'

  s.add_runtime_dependency 'activemodel', '>= 3.1'
  s.add_runtime_dependency 'iban-tools'
  s.add_runtime_dependency 'nokogiri'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
end
