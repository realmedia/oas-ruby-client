require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs = ["lib","test"]
  t.verbose = true
  t.test_files = FileList['test/**/test_*.rb']
end

task :default => :test