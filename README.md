# README

I created this app to learn more about REST APIs in Rails. The app models a notification center REST API. Admin users can create notifications, allocate them to users, and see whether these users have seen the notification. Users can see the notifications allocated to them.

I also used sidekiq to understand jobs and background processes.

## Launching the app 

The app requires Ruby version 3.1.1

To install all dependencies type

```bash
bundle install 
```

You will need to create, migrate and seed a database:

```bash
rails db:create
rails db:migrate
rails db:seed
```

To run the tests, first set up the fixtures:

```bash
rails db:fixtures:load
```

Then you can run all tests via

```bash
rails test
```
To run the app you need to start both a rails server and Sidekiq. To start the server type: 

```bash
rails s
```

You will also need to install and start Sidekiq. Sidekiq will help us push new notifications in an ansynchronous manner, so that these notifications can work in the background. 

To install sidekiq:

```bash
bundle binstub sidekiq
```

and then in a new tap run:

```bash
sidekiq
```

## Accessing the API endpoints

This is the first API I've built from scratch. You would probably go with token-based authentication but I left this out to just focus on the API structure for now. Instead, I have gone with Devise for restricting users to their only their notifications, and for restricting all other API endpoints to admin users. 

In order to run the app locally, given the lack of tokens, you will first need to disable Devise-based authorisation:
1) remove "before_action :authenticate_user!" from the users_controller
2) remove the "is admin.user?" if loop from the assignments and notification controllers
3) you can now run the rails server and use a local desktop version of postman to interact with the API endpoints

### Seeing your own notifications as a user

-> send a POST request to: localhost:3000/api/v1/users/:id, specifying the id of the user. 

### Creating a new notification (admins only)

-> send a POST request to: localhost:3000/api/v1/notifications, the parameters can be "title", "description" and a date

### Allocating a notification to one or more users (admins only)

--> send a POST request to localhost:3000/api/v1/assignments. Parameters need to be "user_id" and "notification_id". 

### Checking if a user has read their notifications
The moment a user has made a successful call to their "view notifications" endpoint, we assume that they have read all the notifications allocated to them. For an admin to check if that has been the case, they can send a GET request to localhost:3000/api/v1/check_read, sending the "user_id" and "notification_id" as a parameter.





