require 'rake'
require 'rubygems'
require 'yaml'
require 'rake/task'


namespace :cucumber do
  Dir.glob(File.join(Dir.pwd, 'run_sets', '*.yml')).each do |file|
    run_set = File.basename(file, '.yml').to_sym
    desc "Run Cucumber #{run_set} features"
    task "#{run_set}" do
      features = YAML.safe_load(File.read(File.join(Dir.pwd, 'run_sets', "#{run_set}.yml"))).join(' ')
      sh "cucumber #{features}"
    end
  end
end
