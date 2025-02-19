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

## 3.3 Builder

- Builder templates generate `XML` and are an alternative to `ERB`.

- Similar to JBuilder but used for XML output.

- An XmlMarkup object (xml) is available in .builder templates.

```bash
xml.em("emphasized")
xml.em { xml.b("emph & bold") }
xml.a("A Link", "href" => "https://rubyonrails.org")
xml.target("name" => "compile", "option" => "fast")
```

```bash
<em>emphasized</em>
<em><b>emph &amp; bold</b></em>
<a href="https://rubyonrails.org">A link</a>
<target option="fast" name="compile" />
```

- Methods with blocks are treated as XML tags with nested elements.

```bash
xml.div {
  xml.h1(@person.name)
  xml.p(@person.bio)
}
```

```bash
<div>
  <h1>David Heinemeier Hansson</h1>
  <p>A product of Danish Design during the Winter of '79...</p>
</div>
```

- More examples are available in the Builder documentation.

## 3.4 Template Compilation

- Rails compiles each template into a method for rendering.

- In development, Rails checks for file modifications and recompiles as needed.

- Fragment Caching allows parts of a page to be cached and expired separately.


# 4. Partials 

- Partials are reusable smaller templates that help break down a view into manageable chunks. They allow you to extract code from a main template into a separate file and render it within the main template. You can also pass data to partials.

## 4.1 Rendering Partials

- To include a partial in a view, use the render method:

```ruby
<%= render "product" %>
```

### Partial Naming Convention

- Partial file names start with an underscore `(_)`.

- When rendering, exclude the underscore:

```ruby
<%= render "application/product" %>
```

- This looks for `_product.html.erb` inside `app/views/application/`.


## 4.2 Using Partials to Simplify Views

- Partials help simplify views by extracting repeated sections into separate files.

- They work like methods in programming—keeping views clean and easier to understand.

```ruby
<%= render "application/ad_banner" %>

<h1>Products</h1>

<p>Here are a few of our fine products:</p>
<% @products.each do |product| %>
  <%= render partial: "product", locals: { product: product } %>
<% end %>

<%= render "application/footer" %>
```

### Breakdown

- **Shared Partials**:

  - `_ad_banner.html.erb` and `_footer.html.erb` contain content used across multiple pages.

  - Keeps layout DRY (Don't Repeat Yourself).

- **Rendering Collections**:

  - `_product.html.erb` is used to render individual products.

  - `<%= render partial: "product", locals: { product: product } %>` passes a product to the partial.

  - Helps keep the main view focused on structure rather than details.

### Benefits of Using Partials

- Enhances code reusability.

- Improves readability and maintainability.

- Helps organize views logically and efficiently.

## 4.3 Passing Data to Partials with locals Option

- When rendering a partial in Rails, you can pass data to it using the locals option. Each key in the locals hash is available as a local variable within the partial.

### Syntax

**Rendering a Partial with locals**

```bash
<%= render partial: "product", locals: { my_product: @product } %>
```

**Using the Passed Local Variable in the Partial**

```bash
<%= tag.div id: dom_id(my_product) do %>
  <h1><%= my_product.name %></h1>
<% end %>
```

### Key Points

- **Partial-local variables**: Variables passed via locals are only available inside the partial.

- **Naming convention**: Typically, you would name the local variable the same as the object being passed (e.g., product instead of my_product).

- **Passing multiple variables**: You can pass multiple variables like this:

```bash
<%= render partial: "product", locals: { my_product: @product, my_reviews: @reviews } %>
```

- **Error handling**: If a variable is referenced in the partial but not passed through locals, an `ActionView::Template::Error` will be raised.

```bash
<% product_reviews.each do |review| %>
  <%# ... %>
<% end %>
```

- This will raise an error if `product_reviews` is not included in `locals`.

### Best Practices

- Always ensure that variables used in partials are passed explicitly through `locals`.

- Use meaningful variable names to avoid confusion between instance variables and local variables in partials.

- When passing multiple values, organize them properly for clarity.

## 4.4 Using local_assigns in Rails Partials

- Each partial in Rails has a method called local_assigns, which allows access to keys passed via the locals: option. If a key is not provided when rendering the partial, local_assigns[:some_key] will return nil.

```bash
<%# app/views/products/show.html.erb %>
<%= render partial: "product", locals: { product: @product } %>

<%# app/views/products/_product.html.erb %>
<% local_assigns[:product]          # => "#<Product:0x0000000109ec5d10>" %>
<% local_assigns[:product_reviews]  # => nil %>
```

### Use Cases

- **Conditional Execution in Partials**

  - Using local_assigns, we can check if a local variable is passed and conditionally perform an action:

  - ```bash
    <% if local_assigns[:redirect] %>
      <%= form.hidden_field :redirect, value: true %>
    <% end %>
    ```

- **Example from Active Storage**

  - Setting image size dynamically based on whether in_gallery is set:

  - ```bash
    <%= image_tag blob.representation(resize_to_limit: local_assigns[:in_gallery] ? [800, 600] : [1024, 768]) %>
    ```

## 4.5 Render Without partial and locals Options

- If partial and locals are the only options, you can omit their keys and provide values directly.

```bash
<%= render partial: "product", locals: { product: @product } %>
```

- can be written as:

```bash
<%= render "product", product: @product %>
```

- Even more concisely:

```bash
<%= render @product %>
```

- This looks for `_product.html.erb` in `app/views/products/`.

- Passes a local variable product set to `@product`.

## 4.6 as and object Options

- By default, objects are assigned to a local variable matching the partial’s name.

```bash
<%= render @product %>
```

- Equivalent to:

```bash
<%= render partial: "product", locals: { product: @product } %>
```

### Using object Option

- Assign a different instance variable to the local variable:

```bash
<%= render partial: "product", object: @item %>
```

- This assigns @item to product inside _product.html.erb.

### Using as Option

- Change the local variable name:

```bash
<%= render partial: "product", object: @item, as: "item" %>
```

- Equivalent to:

```bash
<%= render partial: "product", locals: { item: @item } %>
```

## 4.7 Rendering Collections

### Iterating Over Collections

- Instead of manually iterating over @products and rendering a partial:

```bash
<% @products.each do |product| %>
  <%= render partial: "product", locals: { product: product } %>
<% end %>
```

- Use a single-line shorthand:

```bash
<%= render partial: "product", collection: @products %>
```

- Each instance of the partial gets access to an individual member of the collection using a variable named after the partial (e.g., product for _product.html.erb).

### Shorthand Syntax

- Rails allows an even shorter syntax:

```bash
<%= render @products %>
```

- This assumes @products is a collection of Product instances and automatically determines the correct partial based on naming conventions.

- Works with collections containing multiple model types; Rails selects the correct partial for each instance.

## 4.8 Spacer Templates

### Adding Spacers Between Items

- You can render a separate spacer partial between elements using `:spacer_template`:

```bash 
<%= render partial: @products, spacer_template: "product_ruler" %>
```

- Rails will insert `_product_ruler.html.erb` between instances of `_product.html.erb`.

## 4.9 Counter Variables

### Accessing a Counter Variable

- When rendering a collection, Rails provides an automatic counter variable in the format <partial_name>_counter.

```bash
<%= render partial: "product", collection: @products %>
```

- Inside _product.html.erb:

```bash
<%= product_counter %> # Outputs: 0 for the first product, 1 for the second, etc.
```

### Using a Custom Variable Name

- If using the as: option, the counter variable changes accordingly.

```bash
<%= render partial: "product", collection: @products, as: :item %>
```

- Inside _product.html.erb:

```bash
<%= item_counter %> # Outputs: 0 for the first item, 1 for the second, etc.
```

## 4.10 `local_assigns` with Pattern Matching

- Ruby on Rails supports using Ruby 3.1's pattern matching with `local_assigns`, allowing cleaner and more expressive assignments in partial views.

### Pattern Matching Assignment

- `local_assigns` is a Hash and can be destructured using pattern matching:

```bash
local_assigns => { product:, **options }
product # => "#<Product:0x0000000109ec5d10>"
options # => {}
```

- When rendering a partial, additional options can be extracted and used in helper methods.

```bash
<%# app/views/products/_product.html.erb %>
<% local_assigns => { product:, **options } %>

<%= tag.div id: dom_id(product), **options do %>
  <h1><%= product.name %></h1>
<% end %>

<%# app/views/products/show.html.erb %>
<%= render "products/product", product: @product, class: "card" %>
```

- This results in:

```bash
<div id="product_1" class="card">
  <h1>A widget</h1>
</div>
```

### Variable Renaming with Pattern Matching

- Variables can be renamed while destructuring:

```bash
local_assigns => { product: record }
product             # => "#<Product:0x0000000109ec5d10>"
record              # => "#<Product:0x0000000109ec5d10>"
product == record   # => true
```

### Conditional Fetch with Defaults

- `fetch` can be used to provide a default value when a key is missing:

```bash
<%# app/views/products/_product.html.erb %>
<% local_assigns.fetch(:related_products, []).each do |related_product| %>
  <%# ... %>
<% end %>
```

### Using with_defaults for Compact Default Assignments

- `with_defaults` allows setting default values concisely:

```bash
<%# app/views/products/_product.html.erb %>
<% local_assigns.with_defaults(related_products: []) => { product:, related_products: } %>

<%= tag.div id: dom_id(product) do %>
  <h1><%= product.name %></h1>
  <% related_products.each do |related_product| %>
    <%# ... %>
  <% end %>
<% end %>
```



