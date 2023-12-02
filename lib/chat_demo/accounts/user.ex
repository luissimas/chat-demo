defmodule ChatDemo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatDemo.Chat.Message

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string
    field :name, :string
    field :avatar_url, :string
    field :provider, :string

    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :avatar_url, :provider])
    |> validate_required([:email, :name, :provider])
    |> unique_constraint(:email)
  end
end
