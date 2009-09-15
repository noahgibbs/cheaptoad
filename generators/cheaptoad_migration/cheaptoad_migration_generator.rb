class CheaptoadMigrationGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.directory "db/migrate"
      m.template '20090914074933_ct_migrate.rb',
      		  "db/migrate/20090914074933_ct_migrate.rb"
    end
  end

end
