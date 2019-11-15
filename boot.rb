#require gems
require "pry"
require "active_record"
require "standalone_migrations"
require "pg"
require "rspec"
require "yaml"

#require models
Dir["./models/**/*.rb"].each { |f| require(f) }

#connect db
db_configuration_file = File.join(File.expand_path('..', __FILE__), 'db', 'config.yml')
db_configuration = YAML.load(File.read(db_configuration_file))
ActiveRecord::Base.establish_connection(db_configuration['development'])
