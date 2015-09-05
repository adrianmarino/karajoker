# Karajoker
Another youtube karaoke application.

## Applicaiton setup

#### Requisites
 * Redis
 * Mysql

#### Steps

1. Install mysql lib
  * In Arch

	   ```
	   sudo pacman -S libmysqlclient
	   ```
  * In Debian

	   ```
	   sudo apt-get install libmysqlclient-dev
	   ```

2. Clone repository

 ```
 git clone https://github.com/adrianmarino/karajoker.git
 ```

2. Go to karajoker

 ```
 cd karajoker
 ```

4. Install dependencies

 ```
 bundle install
 ```
5. Start MySQL server

 ```
 bundle exec rake mysql:start
 ```
6. Create db schema

 ```
 bundle exec rake mysql:create_schema; bundle exec rake db:migrate
 ```
7. Check whether the application works perfectly, runing all test (Optional)

 ```
 bundle exec rake test
 ```
8. Start redis

 ```
 redis-server
 ```
9. Start sidekiq worker

 ```
 bundle exec sidekiq -C config/sidekiq.yml
 ```
10. Run application

 ```
 bundle exec rails server
 ```
11. Index top 10 hits between years:
  * Index first 10 songs from a top 100 songs chart at 2015 (This cloud take many time):

	   ```
	   bundle exec rake karajoker:index[10,2015..2015,3000]
	   ```
  * Index all songs of top 100 songs charts from 1970 to 2015 (This cloud take days):

	   ```
	   bundle exec rake karajoker:index[100,1970..2015,3000]
	   ```
    **Note**: Last parameter is the application port.

12. Monitor index process with [Sidekiq](http://localhost:8081/sidekiq).

13. Go to [Karajoker](http://localhost:8081)

## Setup in Docker

#### Requisites
* Docker
* Docker Compose

#### Steps

1. Build images

	```
	bundle exec rake karajoker:server:build
	```
2. Start containers

	```
	bundle exec rake karajoker:server:start
	```
3. Index songs

   ```
   bundle exec rake karajoker:index[10, 2015]
   ```

4. Monitor index process with:
	* [Sidekiq](http://localhost:8081/sidekiq)
	* [Graylog](http://localhost:9000)
		* Username: admin
		* Password: password

7. Go to [Karajoker](http://localhost:8081)
