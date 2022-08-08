require_relative 'lib/in-time-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'in-time-ruby'
  spec.version       = InTimeRuby::VERSION
  spec.authors       = ['Adem Dinarevic']
  spec.email         = ['ademdinarevic@gmail.com']
  spec.homepage      = 'https://github.com/ademdc/in-time-ruby'
  spec.license       = 'MIT'
  spec.summary       = "Ruby client for In Time API"
  spec.description   = "Ruby client for InTime API"
  spec.require_paths = ['lib']
  spec.files         = Dir.glob("{lib}/**/*", File::FNM_DOTMATCH).reject {|f| File.directory?(f) }

  spec.required_ruby_version = '>= 2.3'

  spec.add_runtime_dependency 'rest-client', '~> 2.1.0'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_dependency 'nokogiri', '> 1.12.4'
end