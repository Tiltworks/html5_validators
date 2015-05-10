# HTML5Validators

Automatic client-side validation using HTML5 Form Validation

## What is this?

html5_validators is a gem/plugin for Rails 3+ that enables client-side
validation using ActiveModel + HTML5. Once you bundle this gem on your app,
the gem will automatically translate your model validation code into HTML5
validation attributes on every `form_for` invocation unless you explicitly
cancel it.

## Features

### PresenceValidator => required

    Model:
      class User
        include ActiveModel::Validations
        validates_presence_of :name
      end

    View:
      <%= f.text_field :name %>
      other text_fieldish helpers, text_area, radio_button, and check_box are also available

    HTML:
      <input id="user_name" name="user[name]" required="required" type="text" />

    SPEC:
      http://dev.w3.org/html5/spec/Overview.html#attr-input-required

![PresenceValidator](https://raw.githubusercontent.com/amatsuda/html5_validators/0928dc13fdd1a7746deed9a9cf7e865e13039df8/assets/presence.png)

### LengthValidator => maxlength

    Model:
      class User
        include ActiveModel::Validations
        validates_length_of :name, maximum: 10
      end

    View:
      <%= f.text_field :name %>
      text_area is also available

    HTML:
      <input id="user_name" maxlength="10" name="user[name]" size="10" type="text" />

    SPEC:
      http://dev.w3.org/html5/spec/Overview.html#attr-input-maxlength

### NumericalityValidator => max, min

    Model:
      class User
        include ActiveModel::Validations
        validates_numericality_of :age, greater_than_or_equal_to: 20
      end

    View: (be sure to use number_field)
      <%= f.number_field :age %>

    HTML:
      <input id="user_age" min="20" name="user[age]" size="30" type="number" />

    SPEC:
      http://dev.w3.org/html5/spec/Overview.html#attr-input-max
      http://dev.w3.org/html5/spec/Overview.html#attr-input-min

![NumericalityValidator](https://raw.githubusercontent.com/amatsuda/html5_validators/0928dc13fdd1a7746deed9a9cf7e865e13039df8/assets/numericality.png)

*   And more (coming soon...?)


## Disabling automatic client-side validation

There are four ways to cancel the automatic HTML5 validation

*   form_for option


Set `auto_html5_validation: false` to `form_for` parameter

    View:
      <%= form_for @user, auto_html5_validation: false do |f| %>
        ...
      <% end %>

*   model attribute


Set `auto_html5_validation = false` attribute to ActiveModelish object

    Controller:
      @user = User.new auto_html5_validation: false

    View:
      <%= form_for @user do |f| %>
        ...
      <% end %>

*   model class configuration


Write `auto_html5_validation = false` in ActiveModelish class

    Model:
      class User < ActiveRecord::Base
        self.auto_html5_validation = false
      end

    Controller:
      @user = User.new

    View:
      <%= form_for @user do |f| %>
        ...
      <% end %>

*   html5_validators configuration


Set `config.enabled = false` in Html5Validators

    Controller:
      around_action do |controller, block|
        h5v_enabled_was = Html5Validators.enabled
        Html5Validators.enabled = false if params[:h5v] == 'disable'
        block.call
        Html5Validators.enabled = h5v_enabled_was
      end

## Supported versions

*   Ruby 1.8.7, 1.9.2, 1.9.3, 2.0, 2.1, 2.2, 2.3 (trunk)

*   Rails 3.0.x, 3.1.x, 3.2.x, 4.0.x, 4.1, 4.2, 5.0 (edge)

*   HTML5 compatible browsers


## Installation

Put this line into your Gemfile:
    gem 'html5_validators'

Then bundle:
    % bundle

## Notes

When accessed by an HTML5 incompatible lagacy browser, these extra attributes
will just be ignored.

## Todo

*   more validations


## Copyright

Copyright (c) 2011 Akira Matsuda. See MIT-LICENSE for further details.
