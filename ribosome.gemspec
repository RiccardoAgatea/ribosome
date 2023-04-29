require_relative 'lib/ribosome/version'

Gem::Specification.new do |spec|
  spec.name = 'ribosome'
  spec.version = Ribosome::VERSION
  spec.authors = ['Riccardo Agatea']
  spec.email = ['riccardo.agatea@gmail.com']
  spec.license = 'MIT'

  spec.summary = 'Generate a new ruby project based on a template.'
  spec.description = 'Generate a new ruby project based on a template.'
  spec.homepage = 'https://github.com/RiccardoAgatea/ribosome'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/RiccardoAgatea/ribosome'
  spec.metadata['changelog_uri'] = 'https://github.com/RiccardoAgatea/ribosome'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir __dir__ do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 7.0.0'
  spec.add_dependency 'thor', '~> 1.2'
end
