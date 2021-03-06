require 'rubygems'
require 'crate/version'
require 'tasks/config'

Crate::GEM_SPEC = Gem::Specification.new do |spec|
  proj = Configuration.for('project')
  spec.name         = proj.name
  spec.version      = Crate::VERSION

  spec.author       = proj.author
  spec.email        = proj.email
  spec.homepage     = proj.homepage
  spec.summary      = proj.summary
  spec.description  = proj.description
  spec.platform     = Gem::Platform::RUBY


  pkg = Configuration.for('packaging')
  spec.files        = pkg.files.all
  spec.executables  = pkg.files.bin.collect { |b| File.basename(b) }

  # add dependencies here
  spec.add_dependency( "rake", "~> 0.8.3")
  spec.add_dependency( "configuration", "~> 0.0.5")
  spec.add_dependency( "archive-tar-minitar")
  spec.add_dependency( "amalgalite", ">= 0.8")
  spec.add_dependency( "logging", "~> 0.9" )


  if rdoc = Configuration.for_if_exist?('rdoc') then
    spec.has_rdoc         = true
    spec.extra_rdoc_files = pkg.files.rdoc
    spec.rdoc_options     = rdoc.options + [ "--main" , rdoc.main_page ]
  else
    spec.has_rdoc         = false
  end

  if test = Configuration.for_if_exist?('testing') then
    spec.test_files       = test.files
  end

  if rf = Configuration.for_if_exist?('rubyforge') then
    spec.rubyforge_project  = rf.project
  end

end
