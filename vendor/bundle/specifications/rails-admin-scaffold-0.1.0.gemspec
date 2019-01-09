# -*- encoding: utf-8 -*-
# stub: rails-admin-scaffold 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-admin-scaffold".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kirill Kalachev".freeze]
  s.date = "2014-11-23"
  s.description = "Rails generator which allows to scaffold admin controllers, views with proper (non-namespaced) models, helpers, tests and routes".freeze
  s.email = ["dhampik@gmail.com".freeze]
  s.homepage = "http://github.com/dhampik/rails-admin-scaffold".freeze
  s.licenses = ["MIT".freeze]
  s.rubyforge_project = "rails-admin-scaffold".freeze
  s.rubygems_version = "2.7.8".freeze
  s.summary = "Rails admin controllers scaffolding generator".freeze

  s.installed_by_version = "2.7.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 4.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 4.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.2"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 4.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.2"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
