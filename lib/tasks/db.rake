namespace :db do
  namespace :org do
    BACKUP_DIR = "#{Rails.root}/db/backup"

    def config
      conf = ActiveRecord::Base.connection_db_config
      conf.configuration_hash.values_at(:username, :host, :port, :database)
    end
    
    desc "load db data from dump file"
    task :load => :environment do
      username, host, port, database = config
      file = "#{BACKUP_DIR}/2023-12-21.dump"
      cmd = "mysql -u #{username} -p -h #{host} -P #{port} #{database} < #{file}"
      exec cmd
    end

    desc "dump db data to dump file"
    task :dump => :environment do
      username, host, port, database = config
      file = "#{BACKUP_DIR}/#{Date.today}.dump"
      cmd = "mysqldump -u #{username} -p -h #{host} -P #{port} #{database} > #{file}"
      exec cmd
    end
  end
end
