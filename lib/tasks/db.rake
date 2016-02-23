namespace :db do
  desc 'Create a schemas on DB (test, dev and prd)'
  task 'create-schema' do
    system("mysql -h #{ENV['DB_HOSTNAME']} -u root --password=\"#{ENV['DB_PASSWORD']}\" < db/setup_mysql.sql")
  end

  desc 'Show db info'
  task :config do
    puts "\n\s==========================="
    puts "\s\sDB Config"
    puts "\s==========================="
    puts "\s\s-\sHostname: #{ENV['DB_HOSTNAME']}"
    puts "\s\s-\sUsername: #{ENV['DB_USERNAME']}"
    puts "\s\s-\sPassword: #{ENV['DB_PASSWORD']}"
    puts "\s==========================="
  end
end
