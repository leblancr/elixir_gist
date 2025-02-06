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

How does home get rendered?
1. In router the pipeline for the :browser:
plug :put_root_layout, html: {ElixirGistWeb.Layouts, :root}
This tells Phoenix to use root.html.heex as the layout.

first it renders lib/hello_web/components/layouts/root.html.heex which renders lib/hello_web/components/layouts/app.html.heex which finally includes our contents. 

lib/elixir_gist_web/components/layouts/app.html.heex
Phoenix will use the app.html.heex layout to wrap the content of home.html.heex


iex(1)> user = ElixirGist.Repo.get(ElixirGist.Accounts.User, "e0b7d7d2-171a-45c3-a28a-7f357d8aecb5")
[debug] QUERY OK source="users" db=4.1ms decode=0.7ms queue=0.6ms idle=1748.1ms
SELECT u0."id", u0."email", u0."hashed_password", u0."confirmed_at", u0."inserted_at", u0."updated_at" FROM "users" AS u0 WHERE (u0."id" = $1) ["e0b7d7d2-171a-45c3-a28a-7f357d8aecb5"]
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:386
#ElixirGist.Accounts.User<
__meta__: #Ecto.Schema.Metadata<:loaded, "users">,
id: "e0b7d7d2-171a-45c3-a28a-7f357d8aecb5",
email: "rkba1@proton.me",
confirmed_at: ~U[2024-12-07 04:17:11Z],
gists: #Ecto.Association.NotLoaded<association :gists is not loaded>,
inserted_at: ~U[2024-12-07 04:13:50Z],
updated_at: ~U[2024-12-07 04:17:11Z],
...
>

iex(2)> params = %{name: "Test Gist", description: "A description", markup_text: "Some text"}
%{name: "Test Gist", description: "A description", markup_text: "Some text"}

iex(3)> {:ok, gist} = ElixirGist.Gists.create_gist(user, params)
[debug] QUERY OK source="gists" db=40.1ms queue=0.5ms idle=1158.9ms
INSERT INTO "gists" ("name","description","user_id","markup_text","inserted_at","updated_at","id") VALUES ($1,$2,$3,$4,$5,$6,$7) ["Test Gist", "A description", "e0b7d7d2-171a-45c3-a28a-7f357d8aecb5", "Some text", ~U[2024-12-18 14:51:05Z], ~U[2024-12-18 14:51:05Z], "4d87be22-6913-4884-aa30-f7d6ab0bd149"]
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:386
{:ok,
%ElixirGist.Gists.Gist{
__meta__: #Ecto.Schema.Metadata<:loaded, "gists">,
id: "4d87be22-6913-4884-aa30-f7d6ab0bd149",
name: "Test Gist",
description: "A description",
markup_text: "Some text",
user_id: "e0b7d7d2-171a-45c3-a28a-7f357d8aecb5",
user: #Ecto.Association.NotLoaded<association :user is not loaded>,
comments: #Ecto.Association.NotLoaded<association :comments is not loaded>,
inserted_at: ~U[2024-12-18 14:51:05Z],
updated_at: ~U[2024-12-18 14:51:05Z]
}}

