# -*- encoding: utf-8 -*-
# stub: uikit-rails 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "uikit-rails".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Trent Kocurek".freeze]
  s.date = "2015-12-04"
  s.email = ["t2kocurek@gmail.com".freeze]
  s.homepage = "https://github.com/thinkairship/uikit-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "uikit-rails is a SASS-powered version of uikit, ready to drop right into your SASS powered applications.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass>.freeze, [">= 3.3.4"])
    else
      s.add_dependency(%q<sass>.freeze, [">= 3.3.4"])
    end
  else
    s.add_dependency(%q<sass>.freeze, [">= 3.3.4"])
  end
end
