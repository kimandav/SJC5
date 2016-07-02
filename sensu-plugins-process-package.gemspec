lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'

if RUBY_VERSION < '2.0.0'
  require 'sensu-plugins-process-package'
else
  require_relative 'lib/sensu-plugins-process-package'
end

Gem::Specification.new do |s|
  s.authors                = ['Udaya Bhaskar Reddy Panditi']
  s.date                   = Date.today.to_s
  s.description            = 'This plugin provides Process and associated netstat information'
  s.email                  = '<upanditi@cisco.com>'
  s.executables            = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md CHANGELOG.md)
  s.homepage               = 'https://github.com/sensu-plugins/sensu-plugins-network-checks'
  s.license                = 'MIT'
  s.metadata               = { 'maintainer'         => '@rmc3',
                               'development_status' => 'active',
                               'production_status'  => 'unstable - testing recommended',
                               'release_draft'      => 'false',
                               'release_prerelease' => 'false'
                              }
  s.name                   = 'sensu-plugins-process-package'
  s.platform               = Gem::Platform::RUBY
  s.post_install_message   = 'You can use the embedded Ruby by setting EMBEDDED_RUBY=true in /etc/default/sensu'
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 1.9.3'
  s.summary                = 'Sensu plugins for checking process resource usage, pcpu,pmem,ports,user,name'
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.version                = SensuPluginsProcessPackage::Version::VER_STRING

  s.add_runtime_dependency 'sensu-plugin', '~> 1.2'

  s.add_development_dependency 'bundler',                   '~> 1.7'
  s.add_development_dependency 'github-markup',             '~> 1.3'
  s.add_development_dependency 'pry',                       '~> 0.10'
  s.add_development_dependency 'rake',                      '~> 10.0'
  s.add_development_dependency 'rdoc',                      '~> 4.2.1'
  s.add_development_dependency 'redcarpet',                 '~> 3.2'
  s.add_development_dependency 'rspec',                     '~> 3.1'
  s.add_development_dependency 'rubocop',                   '~> 0.37'
  s.add_development_dependency 'yard',                      '~> 0.8'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-json'
  s.add_development_dependency 'simplecov-rcov'
end
