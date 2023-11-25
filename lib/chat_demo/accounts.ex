defmodule ChatDemo.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ChatDemo.Repo

  alias ChatDemo.Accounts.User

  @doc """
  Fetches the user from the database and create it if it does not yet exists.
  """
  def fetch_or_create_user(params) do
    case User.changeset(%User{}, params) do
      %Ecto.Changeset{valid?: true} = changeset ->
        case get_user_by_email(params.email) do
          %User{} = user ->
            {:ok, user}

          nil ->
            Repo.insert(changeset)
        end

      changeset ->
        {:error, changeset}
    end
  end

  @doc """
  Fetches the user by id.
  """
  def get_user(user_id) do
    Repo.get(User, user_id)
  end

  defp get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end
end
