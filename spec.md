# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app  -- ApplicationController inherit from the Sinatra Base
- [x] Use ActiveRecord for storing information in a database  -- Models inherit from the ActiveRecord Base
- [x] Include more than one model class (e.g. User, Post, Category)  -- User, Project, and Model
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) -- User has_many Projects, Project has_many Models
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) -- Model belongs_to Project, Project belongs_to User
- [x] Include user accounts with unique login attribute (username or email) -- email
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying -- User can create, read, update, and destroy a project
- [x] Ensure that users can't modify content created by other users -- user cannot delete or edit a project if the project's user_id != user.id
- [x] Include user input validations -- does not create or update if input field is empty or contain only non-word character
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) -- /projects/new
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code -- true

Confirm
- [x] You have a large number of small Git commits -- 90+ commits
- [x] Your commit messages are meaningful -- commit messages describe what I did in the commit
- [x] You made the changes in a commit that relate to the commit message -- commit messages describe what I did in the commit
- [x] You don't include changes in a commit that aren't related to the commit message -- true
