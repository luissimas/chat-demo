defmodule ChatDemoWeb.AuthController do
  use ChatDemoWeb, :controller

  alias ChatDemo.Accounts

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: ~p"/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case auth |> params_from_auth() |> Accounts.fetch_or_create_user() do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome to Chat Demo!")
        |> put_session(:user, user)
        |> redirect(to: ~p"/")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong.")
        |> redirect(to: ~p"/")
    end
  end

  defp params_from_auth(%Ueberauth.Auth{info: info, credentials: credentials} = auth) do
    IO.inspect(auth)

    %{
      email: info.email,
      name: info.name,
      avatar_url: info.image,
      provider: "github",
      token: credentials.token
    }
  end
end
