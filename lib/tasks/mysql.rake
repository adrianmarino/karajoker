namespace :mysql do
  desc "Create a new schema on MySQL DB"
  task :create_schema do
    task :create_schema, [:hostname] do |task, args|
      hostname = args.hostname || 'ĺocalhost'
      `mysql -u root -h #{hostname} -p < db/setup_mysql.sql`
    end

    desc "Create a new schema on MySQL DB"
    task :start do
      `sudo systemctl restart mysqld`
    end
  end
end
