# Awesome Answers

Welcome to Awesome Answers project. This is a Rails project.

## Setup
Make sure you have postgres install then run:
rails db:create

<!-- Added the gem for cancancan and then ran the command rails g cancan:ability  -->
<!-- This gave us access to a model file called Ability that is included in all of our other models after we initialize it.  -->
<!-- #CanCanCan will automatically initialize with every request to your controllers. It assumes that you have a method available to the controllers called 'current_user' and it will automatically initialize an 'Ability' object with 'current_user' passed to it. -->

Duplicate 'config/initializers/app_keys.rb.example' to
'config/initializers/app_keys.rb' and put in real values for email SMTP server credentials.
