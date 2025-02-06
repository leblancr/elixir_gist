defmodule ElixirGist.Gists.Gist do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "gists" do
    field :name, :string
    field :description, :string
    field :markup_text, :string
    belongs_to :user, ElixirGist.Accounts.User
    has_many :comments, ElixirGist.Comments.Comment

    timestamps(type: :utc_datetime)
  end

  @doc """
  This is a function that creates the changeset data structure.
  It is used to apply changes to a struct and return a changeset,
  which is a structured representation of the changes.
  gist is a %Gist{} struct

  Returns:
  A changeset that changeset can be passed to other functions
  (e.g., Repo.insert/1, Repo.update/1, etc.) to persist the data to the database,
  while also checking that all validation rules have passed.
  """
  def changeset(gist, attrs) do
    gist
    |> cast(attrs, [:name, :description, :markup_text, :user_id])
    |> validate_required([:name, :description, :markup_text, :user_id])
  end
end
