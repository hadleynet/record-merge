# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "record-merge"
  s.summary = "A library for merging multiple source files for a given patient into a single JSON file suitable for use with popHealth"
  s.description = "A library for merging multiple source files for a given patient into a single JSON file suitable for use with popHealth"
  s.email = "talk@projectpophealth.org"
  s.homepage = "http://github.com/pophealth/record-merge"
  s.authors = ["Marc Hadley"]
  s.version = '0.1.0'
  
  s.add_dependency 'nokogiri', '~> 1.4.4'
  
  s.add_development_dependency "awesome_print", "~> 0.3"

  s.files = Dir.glob('lib/**/*.rb') + Dir.glob('lib/**/*.rake') +
            Dir.glob('js/**/*.js*') + ["Gemfile", "README.md", "Rakefile", "VERSION"]
end

