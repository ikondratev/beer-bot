# beer_bot
```sh
Ruby app with using telegram-bot-ruby 
```

[![Build Status](https://app.travis-ci.com/ikondratev/beer-bot.svg?branch=main)](https://app.travis-ci.com/github/ikondratev/beer-bot)

## Dependencies:
```sh
ruby '2.7.2'

gem 'telegram-bot-ruby'
gem 'figaro'
gem 'dry-system'
gem 'activerecord'
gem 'activesupport'
gem 'rubocop'
gem 'rubocop-rake'
gem 'minitest'
gem 'pg'
```
## Add environment:
Put your own credentials as *.yml file to directory .config/

Variants *.yml: production development test
```sh
      TOKEN: 'prod_token'
```
## Add database:
Rename file database.yml.sample in directory .config/

And add your local db credentials:

```sh
      adapter: "postgresql"
      host:    "localhost"
      encoding: "utf-8"
      database: "test"
      username: "test"
      password: "test"
      port:     "test"
```
## Make migration:
In work directory:
```sh
rake db:migrate
```
## Using:
To start app:
```sh
 ruby -Ilib ./bin/bot production
```