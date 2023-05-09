BRQ Hiring API REST
===

This API was created by way approach to ORM-driven solution, which is a straightforward solution that provide by framework Ruby on Rails.

For improvements in project design, we'll need to decouple the entity and behavior of the Acticverecord in the future. The DDD approach can be a good way to do it.

# Features

Descriptions...

# Sutup
## Project Setup

**Install all gems**:

```console
$ bundle install
```

**Update the database with new data model**:

```console
$ rake db:migrate
```

**Create database**:

```console
$ rake db:seed
```

**Start the web server on `http://localhost:3000` by default**:

```console
$ rails server
```

**Run all RSpec tests**:

```console
$ bundle exec rspec
```

## How to user with docker

**Have docker and docker-compose installed (You can check this by doing docker -v and docker-compose -v)**

**Build image docker and up containers**:
  
```console
$ docker compose up -d --build
```

**Create database**:

```console
$ docker exec api rails db:create
```

**Run migrate**:
```console
$ docker exec api rake db:migrate
```

**Run all RSpec tests**:

```console
$ docker exec api bundle exec rspec
```

You can now try your REST service on link http://localhost:3000!

Run locally, static analysis tool which checks applications for security vulnerabilities.

```console
$ docker exec api brakeman
```

# Fixing

**Error: rails server is already running**
You can remove /app/tmp folder on your machine to fix it.

