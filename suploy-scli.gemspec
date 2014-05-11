# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','suploy-scli','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'suploy-scli'
  s.version = SuployScli::VERSION
  s.author = ['flower-pot', 'jannishuebl', 'FlopsKa']
  s.email = ['fbranczyk@gmail.com', 'jannis.huebl@gmail.com', 'flops.ka@gmail.com']
  s.homepage = 'https://github.com/suploy/suploy-scli'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Command line interface and library for managing a suploy backend'
  s.files = `git ls-files`.split("
")
  s.license = "MIT"
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','suploy-scli.rdoc']
  s.rdoc_options << '--title' << 'suploy-scli' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'suploy-scli'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.10.0')
  s.add_runtime_dependency('jbox-gitolite')
  s.add_runtime_dependency('sshkey')
  s.add_runtime_dependency('docker-api')
end
