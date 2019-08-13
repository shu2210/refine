# -*- encoding: utf-8 -*-
# stub: act-fluent-logger-rails 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "act-fluent-logger-rails".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["TAHARA Yoshinori".freeze]
  s.date = "2018-04-10"
  s.description = "Fluent logger".freeze
  s.email = ["read.eval.print@gmail.com".freeze]
  s.homepage = "https://github.com/actindi/act-fluent-logger-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Fluent logger".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_runtime_dependency(%q<fluent-logger>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<railties>.freeze, [">= 4", "< 5.3"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4", "< 5.3"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<fluent-logger>.freeze, [">= 0"])
      s.add_dependency(%q<railties>.freeze, [">= 4", "< 5.3"])
      s.add_dependency(%q<activesupport>.freeze, [">= 4", "< 5.3"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<fluent-logger>.freeze, [">= 0"])
    s.add_dependency(%q<railties>.freeze, [">= 4", "< 5.3"])
    s.add_dependency(%q<activesupport>.freeze, [">= 4", "< 5.3"])
  end
end
