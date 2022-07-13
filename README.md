# README

## ENVIRONMENT:
  ruby-version: 2.7,6
  bundler-version: 2.1.4
  rails-version: 5.2.8

## Config local environment with:
- Link GoRails: https://gorails.com/setup/osx/12-monterey

## Config with Docker
- git clone source
- download docker: https://docs.docker.com/desktop/mac/install/
- cd source code
- run command: docker-compose up
- open new terminal and run command: docker-compose run webapp rails db:migrate
- open browser and fill: localhost: 3000

## Workflow:
- Sign up user data
- Sign in current user
- Click gallery on menu and try out it

## Login without signup
- email: admin@example.com
- password: 123456

## Unit test
- Open terminal and run command: rspec

