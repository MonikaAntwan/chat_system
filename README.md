# README

Chat system

Prerequisites:

* Github
* Ruby 3.0.0
* Rails 6.1.6
* mysql
* Elasticsearch


Steps to get the application up and running:

1. Clone the the repository from github and navigate to it's folder

git clone https://github.com/MonikaAntwan/chat_system.git

cd path/chat_system

2. Update the database.yml file

Update the database configuration in the database.yml file as required.

path: config/database.yml

3. Create and setup the database

Run the following commands to create and setup the database.

bundle exec rake db:create
bundle exec rake db:migrate

4. Start the Rails server and sidekiq

You can start the rails server and sidekiq using the commands given below.

bundle exec rails s
bundle exec sidekiq


Now http://localhost:3000 should show the default Rails page and you can now access any enpoint.

You can also run the rspecs for the endpoints using the following command:

rspec spec/requests






