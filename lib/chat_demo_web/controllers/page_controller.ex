defmodule ChatDemoWeb.PageController do
  use ChatDemoWeb, :controller

  def home(conn, _params) do
    if conn.assigns.user do
      redirect(conn, to: ~p"/chat")
    else
      render(conn, :home)
    end
  end
end
