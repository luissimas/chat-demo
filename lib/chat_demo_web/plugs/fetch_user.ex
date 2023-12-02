defmodule ChatDemoWeb.Plugs.FetchUser do
  import Plug.Conn

  alias ChatDemo.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    user =
      case get_session(conn, :user_id) do
        nil -> nil
        user_id -> Accounts.get_user(user_id)
      end

    assign(conn, :user, user)
  end
end
