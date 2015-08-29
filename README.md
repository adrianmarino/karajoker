# Karajoker
An other youtube karaoke aplication.

## Setup Application

### Normal setup

Requisites:
 * Redis
 * Mysql

1. Install mysql lib:
  * In Arch
   ```
   pacman -S libmysqlclient
   ```
  * In Debian
   ```
   sudo apt-get install libmysqlclient-dev
   ```
2. Install dependencies:
 ```
 bundle install
 ```
3. Start MySQL server:
 ```
 bundle exec rake mysql:start
 ```
4. Create db schema:
 ```
 bundle exec rake mysql:create_schema; bundle exec rake db:migrate
 ```
5. Check whether the application works perfectly, runing all test (Optional):
 ```
 bundle exec rake test
 ```
6. Start redis:
 ```
 redis-server
 ```
7. Start sidekiq worker:
 ```
 bundle exec sidekiq -C config/sidekiq.yml
 ```
8. Run application:
 ```
 bundle exec rails server
 ```
9. Index top 10 hist between years:
  * Index first 10 songs from a top 100 songs chart at 2015 (This cloud take many time): 
   ```
   ./index 10 2015 2015 3000
   ```
  * Index all songs of top 100 songs charts from 1970 to 2015 (This cloud take days):
   ```
   ./index 100 1970 2015 3000
   ```
    Note: The Last parameter is the application port.

10. Go to [Karajoker](http://localhost:3000)

11. Enjoy.

### Docker setup

Requisites: Dcoker

1. Build images
 ```
 docker-compose build
 ```
2. Start containers
 ```
 docker-compose up -d
 ```
3. Index top 10 hist between years.
  * Index first 10 songs from a top 100 songs chart at 2015 (This cloud take many time): 
   ```
   ./index 10 2015 2015 8081
   ```
  * Index all songs of top 100 songs charts from 1970 to 2015 (This cloud take days): 
   ```
   ./index 100 1970 2015 8081
   ```
    Note: The Last parameter is the application port.

4. Monitor index process from [Sidekiq](http://localhost:8081/sidekiq)

5. Go to [Karajoker](http://localhost:8081)
