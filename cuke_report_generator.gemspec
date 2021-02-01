# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','cuke_report_generator','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'cuke_report_generator'
  s.version = CukeReportGenerator::VERSION
  s.author = 'Joseph Ours'
  s.email = 'jospeh.ours@gmail.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'An html report generator based on cucumber JSON output.  Better than standard HTML reporting'
  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r(^(test|spec|features)/))
  end
  s.require_paths << 'lib'
  # s.has_rdoc = true
  # s.extra_rdoc_files = ['README.rdoc','cuke_report_generator.rdoc']
  # s.rdoc_options << '--title' << 'cuke_report_generator' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'cuke_report_generator'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.16.0')
  s.add_runtime_dependency('activemodel')
  s.add_runtime_dependency('coderay')
  s.add_runtime_dependency('htmlentities')
  s.add_runtime_dependency('require_all')
  s.add_runtime_dependency('pry')
  s.add_runtime_dependency('pry-byebug')
  s.add_runtime_dependency('pry-stack_explorer')
end
