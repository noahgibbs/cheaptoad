class CheaptoadMigrationGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  filename = File.expand_path("templates",
                              File.dirname(__FILE__));
  source_root filename

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    migration_template "migration.rb", "db/migrate/add_cheaptoad_table.rb"
  end

end
