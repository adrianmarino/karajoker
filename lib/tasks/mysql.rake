namespace :mysql do
  desc 'Create a new schema on MySQL DB'
  task :create_schema do
    `mysql -u root -p < db/setup_mysql.sql`
  end

  desc 'Create a new schema on MySQL DB'
  task :start do
    `sudo systemctl restart mysqld`
  end
end
