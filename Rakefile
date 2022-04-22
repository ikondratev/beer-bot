require 'rubygems'
require 'rake'


desc "Run spec"
task default: %i[test rubocop]

require 'rake/testtask'
Rake::TestTask.new do |test|
  test.libs << 'test'
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new do |task|
  task.fail_on_error = true
  task.requires << 'rubocop-rake'
end

namespace :db do
  require 'active_record'
  require 'pg'
  require 'logger'
  require 'yaml'

  file =  if File.exist?('config/database.yml')
            File.open('config/database.yml')
          else
            File.open('config/database.yml.sample')
          end

  db_config = YAML::load(file)

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new("db/migrate/").migrate
    ActiveRecord::Base.logger = Logger.new($stdout)
  end
end


