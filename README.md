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


