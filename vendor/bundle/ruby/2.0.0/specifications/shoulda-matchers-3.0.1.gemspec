# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "shoulda-matchers"
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tammer Saleh", "Joe Ferris", "Ryan McGeary", "Dan Croak", "Matt Jankowski", "Stafford Brunk", "Elliot Winkler"]
  s.date = "2015-10-23"
  s.description = "Making tests easy on the fingers and eyes"
  s.email = "support@thoughtbot.com"
  s.homepage = "http://thoughtbot.com/community/"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.0.3"
  s.summary = "Making tests easy on the fingers and eyes"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 4.0.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 4.0.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 4.0.0"])
  end
end
