# beer_bot
```sh
Ruby app with using telegram_bot_api 
```

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
```sh
    Environment: [production development test]
    Add your own *.yml file 
    Path: config/..
    Example: 
      file_name: production.yml
      TOKEN: 'prod_token'
      DB_NAME: 'prod_base'
      DB_USER_NAME: 'prod_user'
      DB_PASSWORD: 'prod_password'
      DB_HOST: 'db_prod_host'
```
## Using:
```sh
 ruby -Ilib ./bin/bot production
```