Hiring API REST
===

The Hiring API was built using an ORM and MVC pattern based approach, which is a straightforward solution provided by various frameworks such as Ruby on Rails.

However, we can improve Hiring's design to make it more robust, flexible, and scalable. For that, we must decouple the domain entities and their behaviors from the ORM (Activeverecord). Thus, we will isolate the business layer from the data layer using the Repository pattern, we will add some Services that will define the entity behaviors, we will also use the Factory pattern to help in the creation of families of related or dependent objects if that is the case.

In the future, we will apply DDD principles along with Clear Architecture to gain even more flexibility and scalability in this API.

# Features

Descriptions...

# Sutup
## Project Setup

**Install all gems**:

```console
$ bundle install
```

**Setup database**:

```console
$ rails db:setup
```

**Start the web server on `http://localhost:3000`**:

```console
$ rails s -b 0.0.0.0 -p 3000
```

**Run all RSpec**:

```console
$ bundle exec rspec
```

## How to user with docker

**Have docker and docker-compose installed (You can check this by doing docker -v and docker-compose -v)**

**Build image docker and up containers**:
  
```console
$ docker compose up -d --build
```

**Setup database**:

```console
$ docker exec api rails db:setup
```

**Run all RSpec**:

```console
$ docker exec api bundle exec rspec
```

**Start the web server on `http://localhost:3000` by default**:

```console
$ docker exec -it api rails s -b 0.0.0.0 -p 3000
```

You can now try your REST service on link http://localhost:3000!

Run locally, static analysis tool which checks applications for security vulnerabilities.

```console
$ docker exec api brakeman
```

# Fixing

**Error: rails server is already running**
You can remove /app/tmp folder on your machine to fix it.

