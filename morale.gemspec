
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'NAME'
  s.version           = '0.0'
  s.date              = '2010-01-01'
  s.rubyforge_project = 'NAME'

  s.summary     = "Command line interface to create & manage tickets on Morale."
  s.description = "Client library and command-line tool to manage tickets and control your account on Morale."

  s.authors  = ["Brilliant Fantastic"]
  s.email    = 'support@teammorale.com'
  s.homepage = 'http://teammorale.com'

  s.require_paths = %w[lib]
  s.executables = ["morale"]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.add_dependency('hirb', "~> 0.5.0")
  s.add_dependency('httparty', "~> 0.7.8")
  s.add_dependency('json', "~> 1.4.6")
  s.add_dependency('thor', "~> 0.14.6")

  #s.add_development_dependency('DEVDEPNAME', [">= 1.1.0", "< 2.0.0"])

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[]
  # = MANIFEST =
end