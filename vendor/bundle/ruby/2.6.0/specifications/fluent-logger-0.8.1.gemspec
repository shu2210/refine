# -*- encoding: utf-8 -*-
# stub: fluent-logger 0.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "fluent-logger".freeze
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sadayuki Furuhashi".freeze]
  s.date = "2019-05-30"
  s.description = "fluent logger for ruby".freeze
  s.email = "frsyuki@gmail.com".freeze
  s.executables = ["fluent-post".freeze]
  s.files = ["bin/fluent-post".freeze]
  s.homepage = "https://github.com/fluent/fluent-logger-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "fluent logger for ruby".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<msgpack>.freeze, [">= 1.0.0", "< 2"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0.9.2"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec-its>.freeze, [">= 1.1.0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0.5.4"])
      s.add_development_dependency(%q<timecop>.freeze, [">= 0.3.0"])
    else
      s.add_dependency(%q<msgpack>.freeze, [">= 1.0.0", "< 2"])
      s.add_dependency(%q<rake>.freeze, [">= 0.9.2"])
      s.add_dependency(%q<rspec>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<rspec-its>.freeze, [">= 1.1.0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0.5.4"])
      s.add_dependency(%q<timecop>.freeze, [">= 0.3.0"])
    end
  else
    s.add_dependency(%q<msgpack>.freeze, [">= 1.0.0", "< 2"])
    s.add_dependency(%q<rake>.freeze, [">= 0.9.2"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<rspec-its>.freeze, [">= 1.1.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0.5.4"])
    s.add_dependency(%q<timecop>.freeze, [">= 0.3.0"])
  end
end
