# railsblog
Persado Technical Assignment

# Prerequisites
- Docker installed. Tested with version 20.10.

# How to build and Run

## Download the source code
```
git clone git@github.com:abnatal/railsblog.git
cd railsblog
```

## Running w/ Docker

Build and run the container:
```
docker build -t railsblog .
docker run -p 3001:3000 -e SECRET_KEY_BASE=abcdef0123456789 --name railsblog -d railsblog
```
The application will listen on http://localhost:3001

# Technologies used
- Ruby 3.1.3
- Rails 7.0.4
- Devise 4.8
- Bootstrap 5.2.3

# Comments
- For the sake of simplicity, the app validates if the user can edit/delete a post or comment in the controller. There is also an application helper to show/hide the edit/delete buttons on the views. If a more sophisticated authorization check were needed, I would use a Gem like "pundit" or "cancancan".

- I haven't configured Mailer in production, so there is no confirmation for user sign up or password recovering at this time;

## Problems faced

- After adding bootstrap support, the actiontext.css used by rich_text stopped working. I needed to link the CSS directly on "application.html.erb" (stylesheet_link_tag) to get it working (https://github.com/rails/rails/issues/43441)

- When building the Docker image, I got the error "rails assets:precompile - ArgumentError: Missing 'secret_key_base' for 'production' environment". I had to set the variable in the "production.rb" to bypass this (https://github.com/rails/rails/issues/32947)

- The integration of Devise 4.8 and Rails 7 has presented some problems, like flash messages not being shown and invalid URL methods. They were fixed based on the issues https://github.com/heartcombo/devise/issues/5439 and https://github.com/heartcombo/devise/issues/5446

# TODO List
- [ ] Research the best practices for deployment in production. For this project, I've used the rails server in a Docker container behind an Apache server running as a reverse proxy;
- [ ] Implement Pagination for Posts / Comments;
- [ ] Configure Mailer and make Devise signup process confirmable and recoverable;
- [ ] Custom validation messages (perhaps using the custom_error_message gem)
- [ ] Work on the UI to make it look prettier.
