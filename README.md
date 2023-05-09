BRQ Hiring API REST
===

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

**You can now try your REST services (localhost:3000)!**

Running locally, static analysis tool which checks applications for security vulnerabilities.

`docker exec app brakeman`

# Fixing
* Error: rails server is already running
You can remove /app/tmp folder on your machine to fix it.

