# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = "confyio"
  gem.version     = "2.0.0"
  gem.description = "Official Confy API library client for ruby"
  gem.summary     = "Official Confy API library client for ruby"

  gem.author   = "Pavan Kumar Sunkara"
  gem.email    = "pavan.sss1991@gmail.com"
  gem.homepage = "https://confy.io"
  gem.license  = "BSD"

  gem.require_paths = ['lib']

  gem.files = Dir["lib/**/*"]

  gem.add_dependency "faraday", "~> 0.9", ">= 0.9.0"
  gem.add_dependency "json", "~> 1.7", ">= 1.7.7"
end
