# -*- encoding: utf-8 -*-
require File.expand_path('../lib/elsm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joshua Bussdieker"]
  gem.email         = ["jbussdieker@gmail.com"]
  gem.description   = %q{Cloud computing management via puppet}
  gem.summary       = %q{Control EC2 instances with puppet. Supports creating and modifying instances with puppet.}
  gem.homepage      = "http://github.com/jbussdieker/elsm"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "elsm"
  gem.require_paths = ["lib"]
  gem.version       = Elsm::VERSION
end
