defmodule ChatDemoWeb.AuthController do
  use ChatDemoWeb, :controller

  alias ChatDemo.Accounts

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: ~p"/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider} = _params) do
    case auth |> params_from_auth(provider) |> Accounts.fetch_or_create_user() do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: ~p"/chat")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong.")
        |> redirect(to: ~p"/")
    end
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> redirect(to: ~p"/")
  end

  defp params_from_auth(%Ueberauth.Auth{info: info, credentials: credentials}, provider) do
    %{
      email: info.email,
      name: info.name,
      avatar_url: info.image,
      provider: provider,
      token: credentials.token
    }
  end
end
