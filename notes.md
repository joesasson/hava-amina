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
- add `--format documentation` to in order to see a description of the test as it's running instead of just a dot
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

### Oauth

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

3/27

- Continuing on with the tutorial I now need to actually implement the session in the controller
- Okay I did that already, to refresh we want to set a user instance variable in the create action and call the `from_omniauth` method of the `User` class.
- So, it wasn't working just now and I tried putting in a pry to see if twitter was returning the right hash and it was
- I saw the error message was `NoMethodError: undefined method `from_omniauth' for #<Class:0x007fb7078c9108>`
- I realized that I hadn't called the method from the `User` class.
- Instead of doing `User.from_omniauth`, I just did plain `from_omniauth`, oops!
- It still wasn't working, so I checked the user class and sure enough the method was defined as a instance method, which is not what we need
- All I had to do is add the `self` before the method name and that turns it into a class method
- Let's see if it works...
- Yeeeeeeah! It worked! I see 'Welcome Joe Sasson' in the flash
- From now on, make sure to check that I defined method as a class method and that I call the method from the right class
- Next I want to add a `current_user` method that will return the current user based on the user id key that we stored in the session hash this is a convention for all authentication systems
- The method looks like this:
```ruby
def current_user
  @current_user ||= User.find(session[:user_id])
end
```
- This will be called in each view and every time we want to access the user from the session or check if there is a user logged in
- Now we add the information to the index page
- I was having some problems with the autocomplete in Atom because it was treating all suggestions like html tags regardless of the suggestion
- I started disabling packages and I realized that emmet was the culprit
- after further research I discovered a package that won't disturb the native autocomplete that Atom has it's called [`emmet-simplified`](https://atom.io/packages/emmet-simplified)
- Sweet it works!
- Back to SocialFreak
- We want to add the current user's photo to the navbar and their name
- We also want to put a link to log out and a corresponding method in the controller
- How do I implement the logout path in routes?
- I tried defining a get method for the 'logout' path and sending it to `sessions#destroy` but I am getting an error `undefined local variable or method delete` that also happens when I prefix the route with `delete`
- I got it, I need to pass in a symbol to the method options in the `link_to` tag, I was passing in a bareword `delete`
- Nice! Now I see my picture in the navbar
- Add some info to the index page by rendering out the current_user fields
- Add Google auth - [omniauth-google-oauth2](https://github.com/zquestz/omniauth-google-oauth2)

Random Break:
- Reading this article: https://medium.freecodecamp.com/how-to-set-up-a-vpn-in-5-minutes-for-free-and-why-you-urgently-need-one-d5cdba361907#.hqsy9xpek
- https://letsencrypt.org/
- Scary, but I need to use Chrome
- Plus who knows if Opera is actually secure
- I did add the HTTPS everywhere extension though

- Back to google auth
- Add the gem
- Get the google key and the secret key
- Using Figaro for ENV variables
- just add `gem 'figaro'` and `bundle`
- `figaro install` will create a yaml file `config/application.yml`
- it will also add that file to the `.gitignore` file so that the evs are not added to git
- now I need to store the keys that I want as key value pairs in the `application.yml` file
- I deleted the keys from my bash_profile which is frankly a little ridiculous, because it's different for every app
- It works just fine with figaro
- I might need to refer back to the [figaro docs](https://github.com/laserlemon/figaro#deployment) when I deploy
- Back to google auth
- gem is installed, I need to get the keys
- Create a project and add the Google+ API then step through the naming and setup, adding the urls for the app and the callback
- Add the keys to the `omniauth.rb` file in initializers along with some other configuration arguments
- I skipped the facebook section, but I realize that I have to change the hardcoded `Twitter` to `user.provider.capitalize`
- Google's response is not formatted the same way as twitter's and fb, so I need to set the name as 'google' in the `omniauth.rb` file
- Why should I use devise?
- Now Facebook then linkedin then I'll look into adding devise and why then I'll implement authentication for hava amina
- add gem
- create project in fb console and get keys and define urls
- add keys to figaro file
- add provider to omniauth middleware with keys
- add link in navbar
- I'll just skip facebook, I don't have an account so later
- Linkedin add gem, add provider to middleware, create app with localhost and callback, add keys to figaro file, add link to nav
- I also need to configure the class methods because the linkedin auth hash is slightly different
- Now it's broken and I have to debug
- I'm getting the error that the method `get_social_location_for` is missing, but I know that I've defined it in the model
- Let me finish debugging before I go into the metaprogramming article
- The parsing methods for the auth hash also need to be class methods obviously, but I didn't think of that
- for some reason the later version of the omniauth gem was messing it up and by locking the gem to a lower version it fixed it, I'm not sure why
- I found the solution on this so thread: https://stackoverflow.com/questions/33352426/oauth2-login-for-facebook-linkedin-and-google-stopped-working-with-devise-and-o

- What is `class << self`?
- http://yehudakatz.com/2009/11/15/metaprogramming-in-ruby-its-all-about-the-self/
- I'm gonna go a little off tangent for this one
- Before I do that though I want to write about managing processes in bash and a couple of tricks that I learned last week
- When the thing is going slow, the first to do is run the `top` command from bash which will list the top running commands also the `ps aux` command which is `ps` - which stands for process status and aux is the flags that will show processes for all users
- https://unix.stackexchange.com/questions/106847/what-does-aux-mean-in-ps-aux
- a = show processes for all users
- u = display the process's user/owner
- x = also show processes not attached to a terminal
- then when you find processes that you don't need and that are taking up a lot of memory/cpu you can kill them using the pid `kill pid`
- you can kill a range of pid using bash bracket expansion. For example `kill {78330..78337}` will call all the pids in that range
- https://unix.stackexchange.com/questions/181205/how-to-get-tab-completion-when-using-curly-braces-in-bash
- Back to the metaprogramming article
- I understand that defining a method with the `self` scope it creates a class method
- We can also have `class` inherit from `Person` in order to scope all methods as class methods
- https://stackoverflow.com/questions/2505067/class-self-idiom-in-ruby
- `class << foo` syntax opens up foo's singleton class (eigenclass).
- What is a singleton class?
- [wikipedia](https://en.wikipedia.org/wiki/Singleton_pattern)
- https://sourcemaking.com/design_patterns/singleton
- Application only needs one instance of a certain class
- Basically by opening up the singleton class you can define methods for the class scope
- We do this because there are no instances except for that one and now we don't have to write `self` for each method
- I should probably spend some time on this site: https://sourcemaking.com/ it looks cool
- Here another article: http://www.integralist.co.uk/posts/eigenclass.html
- So a singleton method is a method that is defined for a specific instance
- Basically the `class << foo` syntax opens up a context to write to
- When you put an instance on the right side, it opens up the singleton method definition
- when you put `self` on the right side it open up the class method definition
- What is `instance_eval`?
- `instance_eval` basically takes in a block and evaluates it in the context of the object receiver (The object that `instance_eval` is begin called on)
- Basically there is a difference between inheriting the class from self which puts us in the class context and using `instance_eval` which modifies the metaclass and acts slightly different
- Done with that, interesting stuff
- Back to my side side app for error rescuing and then adding github and then adding all these things into hava amina and changing the User table accordingly, namely, I want all the emails
- First the error handling
- basically I'm gonna set the config of the Omniauth class to call the auth_failure action when it fails before the authentication happens
- Let me add github Oauth and then I'm going to add email addresses to these, then add them to hava amina
- add gem, bundle, generate keys, add keys to yaml file, add provider to initializer, add link to nav bar
- It basically worked exactly as expected, I just needed to add a case for the url parser so I just made a check for github and returned the value for the `['GitHub']` index, because y'know, it doesn't need to make sense
- Get email addresses
- How would I be able to filter out the output and find something in the result hash basically?
- the email is basically in the info hash
- I generate a migration `rails g migration AddEmailToUsers email` which does everything for me
- So Twitter and Github are returning emails, I need to add support for linkedin and google


3/28

- In order to get the email from Google I need to just add it into the scope, separated by a comma
- Now for linkedin
- I added the `r_emailaddress` scope on the api side and I tried to just add it to the scope in the initializer separated by a comma but it didn't work
- Now it asked for the permission, but the email is showing up nil in the auth_hash, I wonder why
- Okay I think I got it, I have to add the `email-address` to the fields options
- I also need to restart the server for the changes to take effect because it is an initializer which only runs when the server is started
- Ok, it worked
- Now I have everything I want except for one thing, I want all user's identity to be stored under a single user so that information can be shared between strategies
- https://github.com/omniauth/omniauth/wiki/managing-multiple-providers - this readme addresses that problem
- it also links to [this](http://blog.railsrumble.com/2010/10/08/intridea-omniauth/)
- SideTrack: I want to make the side side project mobile friendly so I need to add a meta tag
- I want to make an atom snippet for that, so I'm going to look it up
- I have the `snippets.cson` file open but I need to know the sytax
- Wow, very easy! Just define which file type should have the suggestion available, The name of the snippet, the prefix which is the shortcut that someone will start typing and the body which is what it gets expanded into:

```js
".html":
  "viewport":
    'prefix': 'viewport'
    'body': '<meta name="viewport" content="width=device-width, initial-scale=1">'
```
- Back to the side side project!
- I want to separate the user and authorization models so that a user can have many authorizations but still keep everything else about them together
- First I need to create a new model for the authorizations
- We need to create an association of User has many Authorizations and Authorization belongs to user
- What do I need to change about my own app now?
- I'll call the new model Identity
- create a model called identity with provider, uid, and user_id fields
- create has_many/belongs_to relationship and add validations
- remove the provider and uid columns from the user
- Add a create and find by omniauth method to the Identity
- Add a create with omniauth method to User
- The user will hold the email address and that will be the uniue identifier, if a user logs in with different email addresses, it will considered a new user
- I can take for granted that the omniauth is going to do what it's going to do so all I need to do is react to the auth_hash data
- So I think I want to keep the session set to the user id and now the identity id, but how will a user log in?
- If there is no user/identity
  - create a user and an identity
  - set current user to the user
- If there is a user but not that identity
  - create a new identity under the existing user
  - set current user to the user
- If there is a user and an identity
  - set current user to the user
- I'll change the models around and implement the model and controller methods
- First define a method that will create a new Identity from auth_hash and another one that finds the Identity based on provider and uid combo
- So I have my find method for the identity
- I am making the create method and now I'm stuck.
- So I'm going to try finding user by id and setting it as the user_id
- But if I don't find any user with that email, I want to create a new user and then set the user key to that
- I need to remove the uid and provider from the User because it will fail validation if not
- So I had to debug a little. I got the Identities and Users to get created but I'm still getting an error
- I looked in the console and I realized that new Identities were getting created each time, which shouldn't be happening
- I added a validation, but I also need to change the flow to prevent this behavior
- Sweet, so I got it to basically work for the first flow of not being logged in at all
- Now it creates a new user if the email is unique but only adds the provider to the user if it's the same email address
- Now for the log in
- Okay that works too!
- Now I can get back to Hava Amina
- I want to implement Oauth on a login page, now that I know how omniauth works I can do it pretty easily, I just need to modify the models a little bit
- I know that I want to use Devise in my app, because I don't want to have write new things for verification and other things that it does easily
- So I'm going to go back to my side app once again to make devise work with omniauth
- I think I'm gonna have to delete my omniauth initializer middleware in order to get the devise middleware to work
- https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
- https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview#before-you-start
- This specifically says that I should not have the initializer there, so I'll remove it and then I'll just follow instructions
- I don't think anything else is different
- http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin/
- Okay so there are other differences
- I need to make the model omniauthable and add the strategies
- I need to create a new controller for the callback
- The controller is there, and it's being hit by the twitter callback
- I just want to make sure the flow that I want is there
- I can just copy paste the code from the `sessions#create` action
- That actually worked and I refactored quite a bit to make it work in a couple of lines
- The only thing is I need to make a new action for each strategy
- Okay I also needed to change the callback url in the setting for the provider for each strategy, but now it's working
- Now I can really get back to business
- Okay steps:
- Add Devise Gem
- Add Figaro Gem and copy keys from the SocialFreak project
- Add omniauth strategy gems
- Add pry-rails gem
- Change models
  - Add Identity Model and add devise to it
  - Add devise methods to Identity model (NOW)
- Create sessions controller
- Add the omniauthable option to devise config
- Add routes for identity and logout
- Define from_omniauth methods (copypasta)
- Add a login page that has a link to each strategy
- Make nav render based on logged_in
- make sure current_user works with devise

3/28

- So I need to debug why devise is not being added to the project
- I tried opening up a new terminal tab
- I tried removing the version from the gem statement in the gemfile
- So the culprit was spring, based on [this so question](https://stackoverflow.com/questions/24889925/cant-install-devise) by removing it from the gemfile, rails was able to recognize it
- Now I need to follow the rest of the checklist

3/29

- I'm going to take care of the devise requirements first
- I need to make a site controller anyways to hold the landing page
