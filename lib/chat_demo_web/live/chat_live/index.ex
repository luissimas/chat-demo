defmodule ChatDemoWeb.ChatLive.Index do
  use ChatDemoWeb, :live_view

  alias ChatDemo.Accounts

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    user = Accounts.get_user(user_id)
    {:ok, assign(socket, :user, user)}
  end
end
