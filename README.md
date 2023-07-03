Hiring API REST
===
The Hiring API was built using an ORM and MVC pattern based approach, which is a straightforward solution provided by various frameworks such as Ruby on Rails.

However, we can improve Hiring's design to make it more maintainable, robust, flexible, and scalable. For that, we must decouple the domain entities and their behaviors from the ORM (Activeverecord) via Dry-rb library. Thus, we will isolate the business layer from the data layer using the Repository pattern, we will add some Services Objects that will define the business task, we will also use the Factory pattern to help in the creation of families of related or dependent objects if that is the case.

In the future, we will apply DDD principles along with Clear Architecture to gain even more flexibility and scalability in this API.


Features
===

A product must have the following information:
* Name (required, limited to 100 characters)
* Price (required, limited to two decimal places)
* Photo (required, should just be the url of the file)
* State (by default it is active)


Design Patterns and Libraries Used
===
Patterns

* **Command**: performs some specific task without having any information about the receiver of the request
* **Repository**: it mediates between the domain and data mapping layers, acting like an in-memory domain object collection
* **Service Object**: performs a single action, in that it encapsulates a process of the domain or business logic. Usually, Service doesn't have any logic of its own.

Libraries

* **Brakeman**: static analysis tool which checks applications for security vulnerabilities.
* **Dry-validation**: use schemas and powerful rules to validate data with explicitness, clarity and precision
* **Dry-types**: build your own data types, constraints and coercions with dry-types
* **Dry-struct**: define your own data structs using typed attributes powered by dry-types.


Project Setup
===

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

## How to use with docker

Have docker and docker-compose installed (You can check this by doing docker -v and docker-compose -v).

**Build images docker**:
  
```console
$ docker compose build
```

**Create and start containers**:
  
```console
$ docker compose up -d
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

## Fixing

**Error: rails server is already running**

You can remove _/app/tmp_ folder on your machine to fix it.


Usage
===

| HTTP verbs | Paths  | Used for |
| ---------- | ------ | --------:|
| POST | /register| Create a user|

Use Case Example
===

Example of endpoint to use product repository.
