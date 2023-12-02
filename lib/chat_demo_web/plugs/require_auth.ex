defmodule ChatDemoWeb.Plugs.RequireAuth do
  import Plug.Conn
  use ChatDemoWeb, :controller

  def init(opts), do: opts

  def call(%{assigns: %{user: user}} = conn, _opts) when user != nil, do: conn
  def call(conn, _opts), do: redirect(conn, to: ~p"/")
end
