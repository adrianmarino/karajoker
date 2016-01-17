# Karajoker
Only another karaoke application.

## Application setup

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

6. Setup on bashrc:

	```
	export DB_HOSTNAME="localhost"
	export DB_USERNAME="root"
	export DB_PASSWORD="Your password"
	```

8. Open a new bash session

9. Setup db
	1. Get db username and password

		```
		bundle exec rake db:config
		```

	2.  Create schema (Require password)

		```
		bundle exec rake db:create-schema
		```

	3. Migrate schema

		```
		bundle exec rake db:migrate
		```


10. Check whether the application works perfectly, runing all test (Optional)

	 ```
	bundle exec rake
	```

11. Start redis

	```
	bundle exec rake redis:start
	```

12. Start sidekiq worker (On other bash session)

	```
	bundle exec rake sidekiq:start
	```

13. Run application

	```
	bundle exec rails server
	```

14. Find and index top karaokes
	 * Index first 10 songs from a top 100 songs chart at 2015 (This cloud take many time):

	   ```
	   bundle exec rake job:index[10,2015..2015,3000]
	   ```

	  * Index all songs of top 100 songs charts from 1970 to 2015 (This cloud take days):

	   ```
	   bundle exec rake job:index[100,1970..2015,3000]
	   ```

  	 **Notes**
		* Last parameter is the application port.
		* On zsh session user  \ before [ or ].

15. Monitor index process with [Sidekiq](http://localhost:8081/sidekiq).

16. Go to [Karajoker](http://localhost:8081)

## Setup in Docker

#### Requisites
* Docker 1.9.1
* Docker Compose 1.5.1

#### Steps

1. Build images: This action is required after some changes on kararajoker application to update these on the docker container.

	```
	bundle exec rake docker:build
	```

2. Start containers

	```
	bundle exec rake docker:start
	```

3. Setup db

	1. Get  container id of karajoker_karajoker

		```
		docker ps
		```

	2. Open a bash session on karajoker_karajoker container

		```
		docker exec -it CONTAINER_ID bash
		```

	3. Get db user and password

		```
		bundle exec rake db:config
		```

	4.  Create schema (Require password)

		```
		bundle exec rake db:create-schema
		```

	5. Migrate schema

		```
		bundle exec rake db:migrate
		```

4. Find and index top karaokes

	 ```
  	bundle exec rake job:index[10,2015]
	```

5. Config greylog input (only one time):

	1. Sign in:
		* Username: admin
		* Password: password
	1. Menu System -> Input
	2. Select "GELF UDP" input type
	3. Launch new input
	4. Title: Karajoker
	5. Launch

6. Monitor index process with:
	* [Sidekiq](http://localhost:8081/sidekiq)
	* [Graylog](http://localhost:9000)

7. Go to [Karajoker](http://localhost:8081)
