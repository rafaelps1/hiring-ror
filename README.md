Hiring API REST
===

We begin build the Hiring API using the ORM (ActiveRecord) and MVC pattern based approach, which is a straightforward solution provided by various frameworks such as Ruby on Rails.

We improve project code using some design patterns to make it more maintainable, robust, flexible, and scalable. For that, we decouple the domain entities and its behaviors from the ORM, thus prevent the Fat ActivieRecord Models via Dry-rb library. We isolate the business layer from the data layer using the Repository pattern. 

Also, we implemented some Services Objects that define the business processes. We use the Factory Method pattern to help us in creation of families of related or dependent objects if that is the case.

In the future, we will apply DDD principles along with Clear Architecture to gain even more flexibility and scalability in this API.

Design Patterns and Libraries Used
===

* **Repository**: it mediates between the domain and data mapping layers, acting like an in-memory domain object collection
* **Service Object**: performs a single action, in that it encapsulates a process of the domain or business logic. Usually, Service doesn't have any logic of its own.
* **Command**: performs some specific task without having any information about the receiver of the request (see LoginTokenService)
* **Factory Method**: provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created (see Command::Sender#call)


* **Brakeman**: static analysis tool which checks applications for security vulnerabilities.
* **Dry-monads**: use to handle errors and exceptions, so that the code is much more understandable and has all the error handling, without all the _if_ s and _else_ s.
* **Dry-validation**: use schemas and powerful rules to validate data with explicitness, clarity and precision
* **Dry-types**: build your own data types, constraints and coercions with dry-types
* **Dry-struct**: define your own data structs using typed attributes powered by dry-types.

Project Setup
===

To run this project with Docker you need to have docker and docker-compose installed (You can check this by doing docker -v and docker-compose -v).

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

Download the [requests collection](https://github.com/rafaelps1/hiring-ror/blob/main/api_endpoints.postman_collection.json) and save it as a file on the file system. Now open Postman and click Import. Select the downloaded JSON file. When the selection is complete, you can see that the JSON file is imported as a Postman collection into the application.

You can now run individual requests against a collection. To execute a request, simply open any specific request from the collection and click the "SUBMIT" button to execute it.
