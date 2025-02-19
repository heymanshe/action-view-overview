# 1. Action View 

- Action View is the V in MVC (Model-View-Controller).

- Works with Action Controller to handle web requests.

- Action Controller retrieves data, while Action View renders the response.

## Templates

- Action View templates (or views) use Embedded Ruby (ERB) to integrate Ruby within HTML.

## Features

- Provides helper methods for generating HTML tags for:

  - Forms

  - Dates

  - Strings

- Allows adding custom helpers to applications.

## Integration with Active Model

- Can use Active Model features like:

  - `to_param`

  - `to_partial_path`

- Action View does not depend on Active Model and can work with any Ruby library.

# 2. Using Action View in Rails

- Action View templates ("views") are stored in subdirectories of app/views.

- Each controller has a matching subdirectory inside app/views.

- View files render responses for specific controller actions.

## Example: Generating an Article Resource with Scaffolding

- Running the command:

```bash
$ bin/rails generate scaffold article
```

- Generates:

  - Controller: `app/controllers/articles_controller.rb`

  - View files in `app/views/articles/`:

    - index.html.erb

    - edit.html.erb

    - show.html.erb

    - new.html.erb

    - _form.html.erb

## Naming Convention

- View files follow the **controller action name** (e.g., `index.html.erb` corresponds to the `index` action in `articles_controller.rb`).

- Rails **automatically** renders the corresponding view at the end of a controller action based on this naming convention.

## Components of Final HTML Response

**ERB File (.html.erb)** – Contains embedded Ruby and HTML.

**Layout Template** – Wraps the view file to provide a consistent structure.

**Partials** – Reusable snippets referenced inside views.

- These components together generate the final HTML response sent to the client.


# 3. Templates

- Rails supports different template formats for rendering responses:

  - ERB (.html.erb): Embedded Ruby for HTML responses.

  - Jbuilder (.json.jbuilder): Uses the Jbuilder gem for JSON responses.

  - Builder (.builder): Uses Builder::XmlMarkup for XML responses.

- Rails determines the template type based on the file extension, e.g., .html.erb for ERB templates and .json.jbuilder for Jbuilder templates.

## 3.1 ERB Templates

### ERB Tags

- `<% %>`: Executes Ruby code without rendering output.

- `<%= %>`: Executes Ruby code and renders output.

```ruby
<h1>Names</h1>
<% @people.each do |person| %>
  Name: <%= person.name %><br>
<% end %>
```

- The loop runs with `<% %>`, and `<%= %>` outputs `person.name` dynamically.

```ruby
<%# WRONG %>
Hi, Mr. <% puts "Frodo" %>
```

- `puts` or `print` does not work inside `ERB` templates.

### ERB Comments

- Use `<%# %>` to add `comments` in ERB, which won't be rendered in the final output.

### Whitespace Control

- `<%- -%>` can be used instead of `<% %>` to suppress leading and trailing whitespaces.

## 3.2 Jbuilder 

- Jbuilder is a gem maintained by the Rails team and included in the default Rails Gemfile. It is used to build JSON responses using templates.

### Installation

- If Jbuilder is not installed, add the following to your Gemfile:

```bash
gem "jbuilder"
```

### Usage

- A Jbuilder object named json is automatically available in templates with a .jbuilder extension.

```bash
json.name "Alex"
json.email "alex@example.com"
```

### Output

```bash
{
  "name": "Alex",
  "email": "alex@example.com"
}
```


