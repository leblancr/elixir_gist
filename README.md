# ElixirGist

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

Setup:
mix phx.new elixir_gist --no-install --binary-id
mix deps.get
mix phx.gen.auth Accounts User users
mix ecto.setup - setup database tables

Make context files, Gist and SavedGist both in same Gists module:
mix phx.gen.context Gists Gist gists user_id:references:users name:string description:text markup_text:text
mix phx.gen.context Gists SavedGist saved_gists user_id:references:users gist_id:references:gists
mix phx.gen.context Comments Comment comments user_id:references:users gist_id:references:gists markup_text:text

To run:
mix phx.server
[info] Running ElixirGistWeb.Endpoint with Bandit 1.6.1 at 127.0.0.1:4000 (http)
[info] Access ElixirGistWeb.Endpoint at http://localhost:4000

login:
rkba1
reddphoenixQ125@

Controllers do:
handling incoming HTTP requests, 
processing data, 
returning a response (usually HTML, JSON, or other formats). 
Controllers define the logic for responding to different routes and actions.


