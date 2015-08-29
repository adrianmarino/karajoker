# Karajoker
An other youtube karaoke aplication.

## Requisites
 * Redis
 * Mysql

## Setup Application

1. Install mysql lib:
  * In Arch
    ```
    $ pacman -S libmysqlclient
    ```
  * In Debian
    ```
    $ sudo apt-get install libmysqlclient-dev
    ```
2. Install dependencies:
    ```
    $ bundle install
    ```
3. Start MySQL server:
    ```
    $ bundle exec rake mysql:start
    ```
4. Create db schema:
    ```
    $ bundle exec rake mysql:create_schema
    $ bundle exec rake db:migrate
    ```
5. Check whether the application works perfectly, runing all test (Optional):
    ```
    $ bundle exec rake test
    ```
6. Start redis:
    ```
    $ redis-server
    ```
6. Start sidekiq worker:
    ```
    $ bin/bundle exec sidekiq -C config/sidekiq.yml
    ```
7. Index top 10 hist between years:
  * Index first 10 songs from a top 100 songs chart at 2015 (This cloud take many time). 
    ```
    $ ./index 10 2015 2015
    ```
   * Index all songs of top 100 songs charts from 1970 to 2015 (This cloud take days). 
     ```
    $ ./index 100 1970 2015
    ```
7. Run application:
    ```
    $ bundle exec rails server
    ```
8. Go to [Karajoker](http://localhost:3000)

9. Enjoy.
