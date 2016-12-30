# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apress/sources/version'

Gem::Specification.new do |spec|
  spec.metadata['allowed_push_host'] = 'https://gems.railsc.ru'
  spec.name          = 'apress-sources'
  spec.version       = Apress::Sources::VERSION
  spec.authors       = ['TamarinEA']
  spec.email         = ['silfar@inbox.ru']

  spec.summary       = %q{Sources}
  spec.description   = %q{Base source classes}
  spec.homepage      = 'https://github.com/abak-press/apress-sources'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_runtime_dependency 'rails', '>= 3.1.12', '< 4.1'
  spec.add_runtime_dependency 'string_tools'
  spec.add_runtime_dependency 'rails-cache-tags'

  spec.add_development_dependency 'rake'

  spec.add_development_dependency 'rspec', '>= 3.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'combustion', '>= 0.5.3'
  spec.add_development_dependency 'appraisal'
end
