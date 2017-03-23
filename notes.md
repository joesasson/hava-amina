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
