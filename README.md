# Karajoker
Another youtube karaoke application.

## Setup

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
 cd karajoker
 ```

3. Install dependencies

 ```
 bundle install
 ```
4. Create schema & migrate

 ```
 bundle exec rake db:create_schema
 bundle exec rake db:migrate
 ```
5. Check whether the application works perfectly, runing all test (Optional):

 ```
 bundle exec rake test
 ```
6. Start redis

 ```
 bundle exec rake redis:start
 ```
8. Start sidekiq worker

 ```
 rake sidekiq:start
 ```
7. Run application

 ```
 bundle exec rails server
 ```
8. Index karaokes
  * First 10 songs from a top 100 songs chart at 2015 (This cloud take many time):

	   ```
	   bundle exec rake job:index_karaokes[10,2015..2015,3000]
	   ```
  * All songs of top 100 songs charts from 1970 to 2015 (This cloud take very long time):

	   ```
	   bundle exec rake job:index_karaokes[100,1970..2015,3000]
	   ```

    **Note**: Last parameter is the application port.

9. Go to [Karajoker](http://localhost:3000)

## Setup with Docker

#### Requisites
* Docker
* Docker Compose

#### Steps

1. Clone repository

 ```
 git clone https://github.com/adrianmarino/karajoker.git
 cd karajoker
 ```
2. Build images

 ```
 bundle exec rake docker:build
 ```
3. Start containers

 ```
 bundle exec rake docker:start
 ```
4. Index karaokes
  * First 10 songs from a top 100 songs chart at 2015 (This cloud take many time):

	   ```
	   bundle exec rake job:index_karaokes[10,2015..2015]
	   ```
  * All songs of top 100 songs charts from 1970 to 2015 (This cloud take very long time):

	   ```
	   bundle exec rake job:index_karaokes[100,1970..2015]
	   ```
5. Monitor jobs with:
	* [Sidekiq](http://localhost:8081/sidekiq)
	* [Graylog](http://localhost:9090)
		* Username: admin
		* Password: password

6. Go to [Karajoker](http://localhost:8081)
