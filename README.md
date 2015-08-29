# Karajoker
An other youtube karaoke application.

## Setup Application

### Normal setup

#### Requisites
 * Redis
 * Mysql

#### Steps

1. Clone repo:
 ```
 git clone https://github.com/adrianmarino/karajoker.git
 ```
2. Go to karajoker:
 ```
 cd karajoker
 ```
3. Install mysql lib:
  * In Arch
   ```
   pacman -S libmysqlclient
   ```
  * In Debian
   ```
   sudo apt-get install libmysqlclient-dev
   ```
4. Install dependencies:
 ```
 bundle install
 ```
5. Start MySQL server:
 ```
 bundle exec rake mysql:start
 ```
6. Create db schema:
 ```
 bundle exec rake mysql:create_schema; bundle exec rake db:migrate
 ```
7. Check whether the application works perfectly, runing all test (Optional):
 ```
 bundle exec rake test
 ```
8. Start redis:
 ```
 redis-server
 ```
9. Start sidekiq worker:
 ```
 bundle exec sidekiq -C config/sidekiq.yml
 ```
10. Run application:
 ```
 bundle exec rails server
 ```
11. Index top 10 hist between years:
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

#### Requisites
* Docker

#### Steps

1. Clone repo:
 ```
 git clone https://github.com/adrianmarino/karajoker.git
 ```
2. Go to karajoker:
 ```
 cd karajoker
 ```
3. Build images
 ```
 docker-compose build
 ```
4. Start containers
 ```
 docker-compose up -d
 ```
5. Index top 10 hist between years.
  * Index first 10 songs from a top 100 songs chart at 2015 (This cloud take many time): 
   ```
   ./index 10 2015 2015 8081
   ```
  * Index all songs of top 100 songs charts from 1970 to 2015 (This cloud take days): 
   ```
   ./index 100 1970 2015 8081
   ```
    Note: The Last parameter is the application port.

6. Monitor index process from [Sidekiq](http://localhost:8081/sidekiq)

7. Go to [Karajoker](http://localhost:8081)
