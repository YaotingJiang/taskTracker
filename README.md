# TaskTracker

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## task tracker part one 

The homepage asks the user to either login or register an account. 
After user logged in, user will see a list of tasks, which they could delete,
show, edit the tasks and assign the tasks to other users and the user 
himself/herself. 

Go to /users will show a list users that had already registered. 

## task tracker part two

* In part two, only managers can assign tasks to others. Everyone can be a manager and
  Everyone can be someone's underling. 
* On navigation bar, there are three links to different pages. 
* After user logged in, in the homepage, you will see all the tasks that are assigned to different users
  including the user's own tasks. The stop and end button will only show up when a specific task is belong to
  current user who logged in. If the current user is a manager, then the delete, show and edit buttons will show up and 
  this user could be able to edit, delete and view the tasks. 
* In task page, you will see a list of tasks that only belong to current user's  underlings. If the current user is 
  not a manager, then this list will be empty. 
* In management page, you will see the user's profile, where it will show three tables including current user's manager
  's info, underlings info as well as a list of users who don't have managers, where you could click the button manage 
  next to that user and become to the manager of that user. Or you can unmanage the users who are already your 
  underlings.  
