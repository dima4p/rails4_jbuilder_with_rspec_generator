rails4_jbuilder_with_rspec_generator
====================================

## Description

This is an extention of standard JbuilderGenerator from gem jbuilder.
The purpose is to create rspec files for index.json.builder and show.json.jbuilder.

Example:

    rails generate scaffold User name:string email:string

Additionally to other files this will create:

    spec/views/users/index.json.builder_spec.rb
    spec/views/users/show.json.builder_spec.rb

### Installation

1. Generate your new rails application:

    rails ApplicationName
    cd ApplicationName

2. Edit "Gemfile" and add "gem haml" to the gem list
3. Either

    gem install haml

...or...

    bundle install

5. Either

    git clone https://github.com/dima4p/rails4_jbuilder_with_rspec_generator.git lib/generators/rails/jbuilder

...or...

    git submodule add https://github.com/dima4p/rails4_jbuilder_with_rspec_generator.git lib/generators/rails/jbuilder

## TODO

* Gemify
