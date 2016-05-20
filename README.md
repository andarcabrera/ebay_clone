# Ebay Clone Rails App
Ebay clone that offers a marketplace for buying and selling items.

## Requirement
- ruby ~> 2.2.1
- bundler >= 1.3.0, < 2.0
- postgresql
- redis

## Installation
Clone the repository and run:

```
bundle install
rake db:create
rake db:migrate
rake db:seed
```
start redis server
```
redis-server
```
start sidekiq
```
bundle exec sidekiq
```
## Usage

Start server:

```
rails s
```

View project at 'http://localhost:3000'

## Tests
From the root directory run:

```
rspec
```

To see tests detail, run:
 ```
rspec spec --format documentation
```

