source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 3.3']
gem 'facter', '>= 1.7.0'
gem 'metadata-json-lint'
gem 'puppet', puppetversion
gem 'puppet-lint', '>= 1.0.0'
gem 'puppet-strings'
gem 'puppet_facts', require: false
gem 'puppetlabs_spec_helper', '>= 1.0.0'
gem 'rspec-puppet'
gem 'rspec-puppet-facts', require: false

# rspec must be v2 for ruby 1.8.7
if RUBY_VERSION >= '1.8.7' && RUBY_VERSION < '1.9'
  gem 'rake', '~> 10.0'
  gem 'rspec', '~> 2.0'
else
  # rubocop requires ruby >= 1.9
  gem 'rubocop'
  gem 'semantic_puppet'
end
