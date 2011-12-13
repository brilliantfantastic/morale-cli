
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'morale'
  s.version           = '1.0.0'
  s.date              = '2011-10-26'
  s.rubyforge_project = 'morale'

  s.summary     = "Command line interface to create & manage tickets on Morale."
  s.description = "Client library and command-line tool to manage tickets and control your account on Morale."

  s.authors  = ["Brilliant Fantastic"]
  s.email    = 'support@teammorale.com'
  s.homepage = 'http://teammorale.com'

  s.require_paths = %w[lib]
  s.executables = ["morale"]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md]

  s.add_dependency('morale-client', "~> 0.0.1")
  s.add_dependency('hirb', "~> 0.5.0")
  s.add_dependency('json', "~> 1.4.6")
  s.add_dependency('thor', "~> 0.14.6")

  #s.add_development_dependency('DEVDEPNAME', [">= 1.1.0", "< 2.0.0"])

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    Gemfile
    Gemfile.lock
    LICENSE
    README.md
    Rakefile
    bin/morale
    features/accounts.feature
    features/login.feature
    features/projects.feature
    features/step_definitions/models.rb
    features/support/env.rb
    features/support/hooks.rb
    features/tickets.feature
    lib/morale.rb
    lib/morale/account.rb
    lib/morale/authorization.rb
    lib/morale/client.rb
    lib/morale/command.rb
    lib/morale/commands/account.rb
    lib/morale/commands/authorization.rb
    lib/morale/commands/project.rb
    lib/morale/commands/ticket.rb
    lib/morale/connection_store.rb
    lib/morale/credentials_store.rb
    lib/morale/flow.rb
    lib/morale/platform.rb
    lib/morale/storage.rb
    morale.gemspec
    spec/morale/account_spec.rb
    spec/morale/client_spec.rb
    spec/morale/command_spec.rb
    spec/morale/connection_store_spec.rb
    spec/morale/credentials_store_spec.rb
    spec/morale/storage_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =
end