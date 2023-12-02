defmodule ChatDemo.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChatDemo.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        email: "any@email.com",
        name: "any-name",
        provider: "any-provider"
      })

    {:ok, user} =
      %ChatDemo.Accounts.User{}
      |> ChatDemo.Accounts.User.changeset(attrs)
      |> ChatDemo.Repo.insert()

    user
  end
end
