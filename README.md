# Setup Application

1. Install mysql2 gem:
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
    $ rake mysql:start
    ```
4. Create db schema:
    ```
    $ rake mysql:create_schema
    ```
5. Populate the database with karaokes:
    ```
    $ rake karajoker:index_karaokes
    ```
6. Check whether the application works perfectly, runing all test (Optional):
    ```
    $ rake test
    ```
7. Run application:
    ```
    $ bundle exec rails server
    ```
8. Go to [Karajoker](http://localhost:3000)
9. Enjoy.
