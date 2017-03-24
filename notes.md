# Hava Amina - Learn from your Mistakes

We are taught from a young age by our schooling system that mistakes are bad, useless and damaging.

The only way our education system responds to a wrong answer or a mistake in understanding is with the red pen and a big F.

In the real world, we know that the fastest and most effective way to learn something, is to keep making mistakes. Mistakes are the way that we get to understanding a system deeply. When we get the wrong answer, we have to ask ourselves questions about the idea that we are trying to understand we need to clarify the problem that we're facing and the system that underlies it.

The way that we learn in school is that there is one way of thinking and getting to an answer, and that way is to absorb information and regurgitate it when we are asked to. Mistakes have no place in this learning system. This is nothing like the way we learn in the real world.

As babies, we are never taught how to walk, there are no chalkboards or tests for learning how to talk. We learn to walk and talk by making many thousands of mistakes and learning from them until we are expert walkers and talkers. Why do we change this model when we get into the classroom?

Hava Amina is a new way of learning, an educational path that puts mistakes first.

With it's simple note taking and reviewing interface, students of any discipline can log their notes on any given topic and have their notes reviewed by a teacher or a peer.

Notes are added in the form of short bullet points of understanding with each point building upon the last.

The goal is to keep adding relevant logical points as they present themselves to the student, resulting in a clear path to understanding.

If the student did not achieve full understanding by the end of the path, a teacher can quickly locate the mistake and dig deeper into that point of understanding, making sure that it becomes clear.

Hava Amina is also a great tool to help a self directed learner manage and review their learning process. Using the platform, every step of the learning process is documented so that a user can see exactly where their understanding broke down and delve deeper into that point.

This is how you would use the platform:

- You log in via oath (facebook, twitter, google, linkedin, evernote, stack overflow, etc)
- You add a topic that you want to learn
- You begin learning about topic
- You add bullet points of understanding or resources like article or tutorial links
- You can save your current understanding of a topic with all bullet points
- You can edit your bullet points
- You can publish your topics online and share with other people

## Tech Stack:

- Right now Rails for the whole thing. Eventually convert the backend into an API and implement frontend as a javascript framework.
- Oath for authentication
- Materialize or Bootstrap for styling
- Heroku for deploy
- [Mockingbird](https://gomockingbird.com) for wireframing
- Rspec for testing


## Domain Modeling

- Users
- Topics
- Insights

- User has many Topics
- Topic belongs to User
- Topic has many Insights
- Insight belongs to Topic

### Columns

- User: email:string, password_digest:string
- Topic: name:string
- Insight: text:string

## Development Goals

- Generate CRUD Actions for each model
- Allow Insights to be added or removed from Topics
- Use TDD - unit tests, controller tests, integration tests
- Wireframe with Mockingbird
- Style views with Materialize
- try to add some animations if possible
- use mobile first principles
- Create Logo with [Logojoy](https://www.logojoy.com/)

## My Notes

3/22

- Initialize project
- `~/.railsrc` will set flag options when running rails new
- Add `-T` to get rid of minitest (so I can add rspec) and `-d postgresql` to set postgres as the db
- Add `gem 'rspec-rails'` to test and development group and `bundle`
- run `rails generate:rspec` to add the spec config and folders
- add `--format documentation` in order to see a description of the test as it's running instead of just a dot
- My domain model is User, Topic, and Insight
- Generate all models and add relationship
- Add tests for validations and associations
- Test that bcrypt is working and also research implementing oauth
- For bcrypt just comment in the bcrypt gem, bundle,  and add `has_secure_password` to `User` model
- https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-rspec
- https://github.com/rspec/rspec-rails
- Writing the tests for the associations, I realized that I forgot the foreign keys for all the models. I will now run a migration to add the columns for user_id in the topics table and a topic_id in the insights table
- I want to write migrations that will generate the column name I will refer to the documentation:
- http://guides.rubyonrails.org/active_record_migrations.html#creating-a-standalone-migration
- In order to generate the migration with the add_column command inside the change method, we need to name the file: `Add<column_name>To<table_name>` and add the name and type of the column as an argument. In my case the command looked like this: `rails g migration AddTopicIdToInsights topic_id:integer`
- run migrations and then run tests
- I finished the validation tests for presence, now I need to add tests for associations
- I'm gonna refactor the tests to use [FactoryGirl Rails](https://github.com/thoughtbot/factory_girl_rails) instead of making models by hand
- So essentially what it does is allow you to store an instance of the model that you want to test with added benefits like incrementing the number automatically if I need it
- All you need to do is add the gem (and bundle) and create a factory template in the factories directory and then `build` it in your spec file
- In order to imply the `FactoryGirl` when running FactoryGirl commands, we can set a custom config in `rails_helper`
- Just add `config.include FactoryGirl::Syntax::Methods` inside the `Rspec.configure` block


3/23

- Today I'm going to be implementing authentication with OAuth2
- https://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/
- https://github.com/doorkeeper-gem/doorkeeper
- https://www.sitepoint.com/getting-started-with-doorkeeper-and-oauth-2-0/
- https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2
- 4 Roles to the Oauth process
- Resource Owner - which is the User of the App
- Client - which is the app itself that is requesting credentials from the Authorization API
- ~~Resource / Authorization Server - Holds credentials of User - this is the API~~
- Resource Server - Holds Credentials of User's Account
- Authorization Server - Verifies identity of User before giving access to User's credentials
- The two servers together are referred to as the API
- There is a 6 step process to the authorization:


  1. App requests permission from User to access Authorization Server
  2. User authorizes request and sends back an authorization grant
  3. App requests an access token from the Authorization Server by presenting authentication of it's own identity and the user's grant
  4. The authorization server sends back an access token
  5. App sends the access token to the resource server and requests data
  6. Resource Server sends back data

  ![Oauth Process](https://assets.digitalocean.com/articles/oauth/abstract_flow.png)  

- I'm still not finished that article, but it looks like the rest is not specific to rails
- That's the basic idea, but what about implementing it myself
- Am I going to run into problems by not having an SSL before deploying?
- Which components do I need to add to my app?
- Should I rely on Oauth completely or use it together with devise?
- https://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/
- https://oauth.net/2/
- It looks like I need to register my app before I can send any requests to the API, does that mean I need to deploy the app in order for it to work?
- Another important point is that the user only authorizes the API for certain permissions in some cases it's reading the credentials, in others it's changing something in the user's account
- All I care about is the User's name and email
- Now I'm going to create a new dummy project to practice Oauth for
- Add Bootstrap with sass you have to remove the require statements from the `application.css` and change it to `.scss` in order to use sass bootstrap
- I followed the instruction [here](https://github.com/twbs/bootstrap-sass) to make it work
- Add `gem 'omniauth-twitter'` and `bundle`
- A strategy is a service that provides an API for OAuth like Twitter
- I need to add a configuration option in the initializers
- Create a new file called `omniauth.rb`
- Add this to the config file:
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
```
- Navigate to apps.twitter.com
- Create New App
- Fill out the form using a unique app name (web url doesn't matter but needs to be valid)
- callback goes to `localhost:3000/auth/twitter/callback`
- In order to store the keys, I edited my .bash_profile to `export` the variable definitions of the key and secret and the config will access my local `ENV` in order to set those keys - [article](http://railsapps.github.io/rails-environment-variables.html)
- Now that Twitter has our app registered and is waiting for requests, we need to set up the next step in the process which is the callback
- Callback always is `auth/:provider/callback`
- Therefore we can set up a route for exactly that route in `routes.rb`
- We can now add a link in the menu pointing to the Twitter API - `'/auth/twitter'`
- Wow! It works! But HOW?
- User clicks a link that point to `host/auth/twitter`
- Somehow my app knows that it should redirect to twitter for the authorization page
- Twitter completes the authentication and redirects to the callback URL which I did not set up yet
- Add the Sessions Controller and `#create` action
- Inside the `#create` action we want to render the authentication hash to yaml
- It doesn't work for some reason and it gives me a missing template error
- If I just render the `request.env['omniauth.auth']` object as json, then it renders out properly
- I get back all my twitter account info including things like followers and following(called friends_count lol)
- We want to save the data in our app somewhere
- We want the name of the service and the user's UID and the user's full name, location, avatar, profile URL
- Generate User model to store this information with fields for each item
- `rails g model User provider uid name location image_url url`
- provider and uid cannot be null
- I need to add an index to provider and uid
- What's an index in SQL and why is it important?
- http://stackoverflow.com/questions/2955459/what-is-an-index-in-sql
- http://www.programmerinterview.com/index.php/database-sql/what-is-an-index/
- Essentially a database index is like a phone book index
- In a phone book the names are all split up based on a letter in the alphabet, then if you need to search for a name, you can first look for that letter then look for the name within that letter
- without an index, you would have to look through the entire phone book for a single name!
- The way it works in a db is that we have a data structure like a binary tree that we can search for a certain index and then search in that index for an exact match of what we need
- A binary tree is just a structure that has two nodes under every node
- Apparently the index calls were causing the migration to fail so I had to remove them and now it works fine
- Back to the SessionsController, fill in the create method to be set from ominauth with the `from_omniauth` method which we will define
- Add a success and error flash for each one
- `from_omniauth` is a class method of `User` that will find_or_create by uid
