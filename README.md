# Weather

Basic Phoenix Web App with weather information from airports in the United States. Data source: [US National Weather Service](http://w1.weather.gov/xml/current_obs/). Idea: [Elixir in Action](https://www.manning.com/books/elixir-in-action) - Chapter 13.

# TODO
- Errors - https://hexdocs.pm/phoenix/errors.html
- Tests - Bring over tests for xml feed parsing. Read: https://hexdocs.pm/phoenix/testing.html and onwards. Missing test for authentication in controller (401 for no authentication).

# Phoenix stuff:

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
