defmodule ChatDemo.AccountsTest do
  use ChatDemo.DataCase

  alias ChatDemo.Accounts
  alias ChatDemo.Accounts.User

  describe "users" do
    alias ChatDemo.Accounts.User

    import ChatDemo.AccountFixtures

    test "fetch_or_create_user/1 returns the existing user if it already exist" do
      user = user_fixture()

      params = %{
        email: user.email,
        name: user.name,
        provider: user.provider
      }

      assert {:ok, user} == Accounts.fetch_or_create_user(params)
    end

    test "fetch_or_create_user/1 creates a new user if it does not exist" do
      params = %{
        email: "new-user@email.com",
        name: "any-name",
        provider: "any-provider"
      }

      {:ok, %User{} = user} = Accounts.fetch_or_create_user(params)

      assert user.email == params.email
      assert user.name == params.name
      assert user.provider == params.provider
    end
  end
end
