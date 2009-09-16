class CtMigrate < ActiveRecord::Migration
  def self.up
    create_table "notices", :force => true do |t|
      t.string :api_key, :limit => 100
      t.string :error_message, :limit => 200
      t.string :error_class, :limit => 100
      t.string :backtrace_digest, :limit => 256
      t.text :session
      t.text :request
      t.text :environment
      t.text :backtrace

      t.timestamps
    end

    add_index("notices", "backtrace_digest")
  end

  def self.down
    drop_table "notices"
    remove_index("notices", "backtrace_digest")
  end
end
